const stripePayment = require("../payment"),
    processPayment = require("../processPayment"),
    dataProvider = require("../dataProvider"),
    submitApplication = require("../submitApplication"),
    sendReceipts = require("../sendReceipts"),
    passport = require("passport"),
    httpStatusCodes = require("../httpStatusCodes"),
    multer = require("multer"),
    memoryStore = require("../memoryStore");

const therapistRoutes = require("./therapist");

const storage = multer.memoryStorage();
const upload = multer({ storage }).array("files", 2);

const getCities = async(_, res) => res.send(dataProvider.getCities());

const getTreatmentsInCity = async(req, res) => res.send(await dataProvider.getTreatmentsInCity(req.params.cityId));

const getAllTreatments = async(_req, res) => res.send(await dataProvider.getAllTreatments());

const getAllTherapists = async(_req, res) => res.send(await dataProvider.getAllTherapists());

const getTherapistsForTreatment = async(req, res) =>
    res.send(await dataProvider.getTherapistsForTreatment(req.params.treatmentId));

const updateTherapist = async(req, res) =>
    res.send(await dataProvider.updateTherapist(req.params.therapistId, req.body));

const uploadFiles = async(req, res) => {
    upload(req, res, err => {
        if (err) {
            res.status(500).json(err);
            return res.send();
        }

        const emailAddress = req.files[0].originalname.split("-")[0];
        memoryStore[emailAddress] = req.files;
        return res.send("ok");
    });
};

const getTherapist = async(req, res, next) => {
    if (!(req && req.user && req.user.therapistId)) {
        res.status(httpStatusCodes.unauthorized).json({ message: "therapist not found" });
        return;
    }

    const therapistId = req.user.therapistId;
    const query = async() => await dataProvider.getTherapistById(therapistId);
    return await dataResponse(query, res, next);
};

const getDiscount = async(req, res) => res.send(await dataProvider.getDiscount(req.params.discountCode));

const getGiftTypes = (_, res) => res.send(dataProvider.getGiftTypes());

const getGiftCode = async(req, res) => {
    const gift = await dataProvider.getGift(req.params.giftCode);
    gift && !gift.isExpired ?
        res.send({
            giftCode: gift.giftCode,
            gift: gift.details.gift,
            emailAddress: gift.details.recipient.emailAddress
        }) :
        res.status(httpStatusCodes.notFound).send();
};

const dataResponse = async(action, res, next) => {
    try {
        return res.send(await action());
    } catch (exception) {
        next(exception);
    }
};

const signUp = async(req, res, next) => {
    const { user, password } = req.body;

    const response = await dataProvider.ensureUser({...user, provider: "local", password });
    if (!response.success)
        return res
            .status(httpStatusCodes.conflict)
            .send({ errorMessage: "An account with this email address already exists." });

    req.body.email = user.email;
    next();
};

const isAdmin = (req, res, next) =>
    req.isAuthenticated() && req.user.isAdmin ?
    next() :
    res.status(httpStatusCodes.unauthorized).send({ errorMessage: "Authentication required." });

module.exports = app => {
    // get endpoints
    app.get("/cities", getCities);
    app.get("/cities/:cityId/treatments", getTreatmentsInCity);
    app.get("/therapists", getAllTherapists);
    app.get("/treatments", getAllTreatments);
    app.get("/treatments/:treatmentId/therapists", getTherapistsForTreatment);
    app.get("/discounts/:discountCode", getDiscount);
    app.get("/giftTypes", getGiftTypes);
    app.get("/giftCode/:giftCode", getGiftCode);

    // auth endpoints
    app.get("/auth/recentAppointments", isAdmin, async(_, res) => {
        const [appointments, therapists, treatments] = await Promise.all([
            dataProvider.getRecentAppointments(),
            dataProvider.getAllTherapists(),
            dataProvider.getAllTreatments()
        ]);

        appointments.forEach(appointment => {
            const treatment = treatments.find(x => x.id === appointment.treatmentId);
            const therapist = therapists.find(x => x.id === appointment.therapistId);

            appointment.treatment = treatment.name;
            appointment.therapist = (therapist && therapist.name) || "Any Therapist";
            return appointment;
        });

        return res.send(appointments);
    });

    app.post("/auth/appointments(:id)/update", isAdmin, async(req, res) => {
        const id = req.params.id;
        const appointment = req.body;
        if (!(id === `(${appointment._id})`)) return res.status(httpStatusCodes.badRequest).send();

        await dataProvider.updateAppointment(appointment);
        return res.send();
    });

    app.get("/auth/validate", (req, res) => res.send({ user: req.user }));
    app.post("/auth/signUp", signUp, passport.authenticate("local"), (req, res) => res.send(req.user.toClientObject()));
    app.post("/auth/local", passport.authenticate("local"), (req, res) => res.send(req.user.toClientObject()));
    app.get("/auth/google", passport.authenticate("google", { scope: ["profile", "email"] }));
    app.get("/auth/google/redirect", passport.authenticate("google"), (req, res) => res.send(req.user.toClientObject()));
    app.get("/auth/facebook", passport.authenticate("facebook", { scope: ["profile", "email"] }));
    app.get("/auth/facebook/redirect", passport.authenticate("facebook"), (req, res) => res.send(req.user));
    app.get("/auth/logout", (req, res) => {
        req.logout();
        res.send();
    });

    // admin endpoints
    app.get("/therapists/me", getTherapist);

    // post endpoints
    app.post("/stripePayment", stripePayment);
    app.post("/processPayment", processPayment);
    app.post("/therapists/:therapistId", updateTherapist);
    app.post("/submitapplication", submitApplication);
    app.post("/sendReceipts", sendReceipts);
    app.post("/uploadFiles", uploadFiles);

    therapistRoutes(app);
};