import express from 'express';
import insuranceController from '../controllers/insurance.controller.js';
import { authMiddleware } from '../middleware/auth.js'; // Ensure only logged-in users access these routes

const insuranceRoutes = express.Router();

// Add or Update Insurance
insuranceRoutes.post('/add-or-update', authMiddleware, insuranceController.addOrUpdateInsurance);

// Get Insurance Details
insuranceRoutes.get('/details', authMiddleware, insuranceController.getInsuranceDetails);

// Delete Insurance (optional)
insuranceRoutes.delete('/delete', authMiddleware, insuranceController.deleteInsurance);

export default insuranceRoutes;
