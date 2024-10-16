import Claim from '../models/claim.model.js';
import Insurance from '../models/insurance.model.js';

const claimController = {
  // File a New Insurance Claim
  fileInsuranceClaim: async (req, res) => {
    try {
      const { insuranceId, amountClaimed } = req.body;
      const userId = req.user;

      // Check if the user has the insurance they are claiming for
      const insurance = await Insurance.findOne({ _id: insuranceId, userId });
      if (!insurance) {
        return res.status(404).json({ success: false, message: 'Insurance not found' });
      }

      const claim = new Claim({
        insuranceId,
        amountClaimed,
        userId,
      });

      await claim.save();
      res.status(200).json({ success: true, data: claim });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Retrieve All Claims for a User
  getUserClaims: async (req, res) => {
    try {
      const claims = await Claim.find({ userId: req.user });
      res.status(200).json({ success: true, data: claims });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Update Claim Status (Admin or Provider Functionality)
  updateClaimStatus: async (req, res) => {
    try {
      const { claimId, status } = req.body;
      let claim = await Claim.findById(claimId);

      if (!claim) {
        return res.status(404).json({ success: false, message: 'Claim not found' });
      }

      claim.status = status; // Pending, Approved, Rejected
      claim = await claim.save();
      res.status(200).json({ success: true, data: claim });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },
};

export default claimController;
