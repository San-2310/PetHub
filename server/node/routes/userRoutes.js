import express from 'express';
import { 
  saveOrUpdateUser, 
  getUser, 
  addPetToUser, 
  removePetFromUser 
} from '../controllers/user.controller.js';

const router = express.Router();

router.post('/saveUserData', saveOrUpdateUser);
router.get('/:id', getUser);
router.post('/:id/pets', addPetToUser);
router.delete('/:userId/pets/:petId', removePetFromUser);

export default router;