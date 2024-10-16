import multer from 'multer';
import path from 'path';
import crypto from 'crypto';

// Configure multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './petpics');
  },
  filename: function (req, file, cb) {
    crypto.randomBytes(12, (err, name) => {
      const fn = name.toString('hex') + path.extname(file.originalname);
      cb(null, fn);
    });
  }
});

// Create multer instance
const upload = multer({ storage: storage });

// Export using ES module syntax
export default upload;
