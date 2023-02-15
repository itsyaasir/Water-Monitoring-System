import {
    Response, Request
} from "express";

export const successResponse = (_req: Request, res: Response, message: string, data: any) => {
    res.status(200).send({
        message,
        data,
        success: true,
    });
}

export const errorResponse = (_req: Request, res: Response, message: string, error: any) => {
    res.status(400).send({
        message,
        error,
        success: false,
    });
}

export const validateFields = (req: Request, res: Response, fields: string[]) => {
    const missingFields = fields.filter((field) => !req.body[field]);
    if (missingFields.length) {
        return errorResponse(req, res, `Missing fields: ${missingFields.join(', ')}`, null);
    }
    return null;
}

