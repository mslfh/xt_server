import { Router } from 'express';
import { createDepartment, getAllDepartments, updateDepartment, deleteDepartment } from '../controllers/departmentController.js';

const router = Router();

router.get('/', getAllDepartments);
router.post('/', createDepartment);
router.put('/:id', updateDepartment);
router.delete('/:id', deleteDepartment);
export default router;
