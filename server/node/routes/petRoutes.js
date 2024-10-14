import express from 'express';
import { saveOrUpdatePet, getPet } from '../controllers/pet.controller.js';

const router = express.Router();

router.post('/savePetData', saveOrUpdatePet);
router.get('/:id', getPet);

export default router;