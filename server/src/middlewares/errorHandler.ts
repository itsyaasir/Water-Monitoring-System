import { ValidationError } from "express-validation"
import { Response, Request, NextFunction
 } from "express"
import { errorResponse } from "../utils";
import { ContainerTypes, ExpressJoiError } from "express-joi-validation";

const errorHandler = (err: Error | ExpressJoiError | any, req: Request, res: Response, next: NextFunction) => {


    if (err.type in ContainerTypes) {
        return errorResponse(req, res, err.message, 400);
    }

    return errorResponse(req, res, err.message, 500);
};

export default errorHandler;