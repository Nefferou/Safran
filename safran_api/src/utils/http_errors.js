class HttpError extends Error {
    constructor(status, code, publicMessage) {
        super(publicMessage);
        this.status = status;
        this.code = code;
        this.publicMessage = publicMessage;
    }
}
module.exports = HttpError;
