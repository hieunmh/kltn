import multer from 'multer';

// Configure multer storage
const storage = multer.memoryStorage(); // Stores files in memory
const upload = multer({ storage });

export default upload;