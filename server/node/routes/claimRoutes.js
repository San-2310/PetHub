import express from 'express';
import claimController from '../controllers/claim.controller.js';
import { authMiddleware } from '../middleware/auth.js'; // Ensure only logged-in users access these routes
import { adminMiddleware } from '../middleware/admin.js'; // Only admins/providers should update claim status

const claimRoutes = express.Router();

// File a New Claim
claimRoutes.post('/file', authMiddleware, claimController.fileInsuranceClaim);

// Get User Claims
claimRoutes.get('/user-claims', authMiddleware, claimController.getUserClaims);

// Update Claim Status (Admin/Provider Only)
claimRoutes.put('/update-status', adminMiddleware, claimController.updateClaimStatus);

export default claimRoutes;
