import User from '../models/user.model.js';

export const saveOrUpdateUser = async (req, res) => {
  try {
    const { userId, ...userData } = req.body;

    let user;
    if (userId) {
      user = await User.findByIdAndUpdate(userId, userData, { new: true, runValidators: true });
    } else {
      user = new User(userData);
      await user.save();
    }

    res.status(200).json({ success: true, data: user });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
};

export const getUser = async (req, res) => {
  try {
    const userId = req.params.id;
    const user = await User.findById(userId);
    
    if (!user) {
      return res.status(404).json({ success: false, error: 'User not found' });
    }

    res.status(200).json({ success: true, data: user });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
};