import Insurance from '../models/insurance.model.js';

const insuranceController = {
  // Add or Update Insurance for a User
  addOrUpdateInsurance: async (req, res) => {
    try {
      const { provider, policyNumber, coverageDetails, expirationDate } = req.body;
      const userId = req.user;

      let insurance = await Insurance.findOne({ userId });
      if (insurance) {
        // Update existing insurance
        insurance.provider = provider;
        insurance.policyNumber = policyNumber;
        insurance.coverageDetails = coverageDetails;
        insurance.expirationDate = expirationDate;
      } else {
        // Add new insurance
        insurance = new Insurance({
          provider,
          policyNumber,
          coverageDetails,
          expirationDate,
          userId,
        });
      }

      await insurance.save();
      res.status(200).json({ success: true, data: insurance });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Retrieve User's Insurance Details
  getInsuranceDetails: async (req, res) => {
    try {
      const insurance = await Insurance.findOne({ userId: req.user });
      if (!insurance) {
        return res.status(404).json({ success: false, message: 'Insurance not found' });
      }
      res.status(200).json({ success: true, data: insurance });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },

  // Delete Insurance (optional feature)
  deleteInsurance: async (req, res) => {
    try {
      const insurance = await Insurance.findOneAndDelete({ userId: req.user });
      if (!insurance) {
        return res.status(404).json({ success: false, message: 'Insurance not found' });
      }
      res.status(200).json({ success: true, message: 'Insurance deleted successfully' });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },
};

export default insuranceController;
