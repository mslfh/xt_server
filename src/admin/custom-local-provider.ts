import path from 'path';
import fs from 'fs/promises';

class CustomLocalProvider {
    bucket: string;
    opts: { baseUrl: string };

    constructor(bucket: string, opts: { baseUrl: string }) {
        this.bucket = bucket;
        this.opts = opts;
    }

    async upload(file, key) {
        const filePath = path.join(this.bucket, key);
        await fs.mkdir(path.dirname(filePath), { recursive: true });
        console.log(`Copying ${file.path} to ${filePath}`);
        await fs.copyFile(file.path, filePath);
        await fs.unlink(file.path); // Remove the temporary file
    }

    async delete(key) {
        const filePath = path.join(this.bucket, key);
        await fs.unlink(filePath);
    }

    path(key) {
        return `${this.opts.baseUrl}/${encodeURIComponent(key)}`;
    }
}

export default CustomLocalProvider;