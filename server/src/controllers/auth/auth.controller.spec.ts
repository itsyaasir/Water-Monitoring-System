import { register, login } from './auth.controller'

import { getMockReq, getMockRes } from '@jest-mock/express'
describe('AuthController', () => {
  // Mock the request and response objects
  const req = getMockReq()
  const { res, next, clearMockRes } = getMockRes()

  // Clear the mock response object after each test
  afterEach(() => {
    clearMockRes()
  }
  )

  describe('register', () => {
    it('should return a 200 status code', async () => {
      await register(req, res, next)
      expect(res.status).toHaveBeenCalledWith(200)
    })
  }
  )

  // incorrect fields
  describe('register', () => {
    it('should return a 400 status code', async () => {
      req.body = {
        email: ''
      }
      await register(req, res, next)
      expect(res.status).toHaveBeenCalledWith(400)
    })
  }

  )

  describe('register', () => {
    it('should return a 400 status code', async () => {
      req.body = {
        password: ''
      }
      await register(req, res, next)
      expect(res.status).toHaveBeenCalledWith(400)
    })
  }
  )

  describe('login', () => {
    it('should return a 200 status code', async () => {
      await login(req, res, next)
      expect(res.status).toHaveBeenCalledWith(200)
    })
  }
  )

  // incorrect fields
  describe('login', () => {
    it('should return a 400 status code', async () => {
      req.body = {
        email: ''
      }
      await login(req, res, next)
      expect(res.status).toHaveBeenCalledWith(400)
    })
  }
  )

  describe('login', () => {
    it('should return a 400 status code', async () => {
      req.body = {
        password: ''
      }
      await login(req, res, next)
      expect(res.status).toHaveBeenCalledWith(400)
    })
  }
  )
}

)
