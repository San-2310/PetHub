import User from '../models/user.model.js';
import Pet from '../models/pet.model.js';

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

export const addPetToUser = async (req, res) => {
  try {
    const userId = req.params.id;
    const petData = req.body;

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ success: false, error: 'User not found' });
    }

    const pet = new Pet({
      ...petData,
      owner: userId
    });
    await pet.save();

    user.pets = user.pets || [];
    user.pets.push(pet._id);
    await user.save();

    res.status(200).json({ success: true, data: { user, pet } });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
};

export const removePetFromUser = async (req, res) => {
  try {
    const userId = req.params.userId;
    const petId = req.params.petId;

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ success: false, error: 'User not found' });
    }

    const pet = await Pet.findById(petId);
    if (!pet) {
      return res.status(404).json({ success: false, error: 'Pet not found' });
    }

    if (pet.owner.toString() !== userId) {
      return res.status(403).json({ success: false, error: 'This pet does not belong to the user' });
    }

    user.pets = user.pets.filter(id => id.toString() !== petId);
    await user.save();

    await Pet.findByIdAndDelete(petId);

    res.status(200).json({ success: true, message: 'Pet removed successfully' });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
};