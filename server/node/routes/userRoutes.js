import express from 'express';
import { saveOrUpdateUser, getUser } from '../controllers/user.controller.js';

const router = express.Router();

router.post('/saveUserData', saveOrUpdateUser);
router.get('/:id', getUser);

export default router;