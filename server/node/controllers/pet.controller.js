import Pet from '../models/pet.model.js';
import QRCode from 'qrcode';
import upload from '../config/multerconfig.js';

const generateQRCode = async (petData) => {
  try {
    // Generate QR code as a data URL
    const qrCodeDataUrl = await QRCode.toDataURL(JSON.stringify(petData), {
      errorCorrectionLevel: 'H',
      type: 'image/png',
      quality: 0.92,
      margin: 1
    });
    return qrCodeDataUrl;
  } catch (error) {
    console.error('Error generating QR code:', error);
    throw error;
  }
};
//
export const saveOrUpdatePet = (upload.single('image'),async function (req, res){
  try {
    const { petId, ...petData } = req.body;

    let pet;
    if (petId) {
      pet = await Pet.findById(petId);
      if (!pet) {
        return res.status(404).json({ success: false, error: 'Pet not found' });
      }
      Object.assign(pet, petData);
    } else {
      pet = new Pet(petData);
    }

    // Generate QR code
    pet.qrCodeLink = await generateQRCode(pet);
    pet.pic=req.file.filename;
    await pet.save();

    res.status(200).json({ success: true, data: pet });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

export const getPet = async (req, res) => {
  try {
    const petId = req.params.id;
    const pet = await Pet.findById(petId);
    
    if (!pet) {
      return res.status(404).json({ success: false, error: 'Pet not found' });
    }

    res.status(200).json({ success: true, data: pet });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
};