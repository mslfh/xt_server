import React, { useState } from 'react';
import { Box, Label, Input, Button } from '@adminjs/design-system';
import axios from 'axios';

const VideoUploadEditComponent = (props) => {
  const { record, onChange } = props;
  const [selectedFile, setSelectedFile] = useState(null);

  const handleFileChange = (event) => {
    const file = event.target.files[0];
    setSelectedFile(file);
    onChange('file', file);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!selectedFile) {
      alert('Please select a video file to upload.');
      return;
    }

    const formData = new FormData();
    formData.append('video', selectedFile);
    formData.append('fileId', record.id);

    try {
      const response = await axios.post('/uploadVideo', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      const { s3Key, bucket, mime } = response.data;
      onChange('s3Key', s3Key);
      onChange('bucket', bucket);
      onChange('mime', mime);

      alert('Video uploaded successfully');
    } catch (error) {
      alert('Error uploading video');
    }
  };

  return (
    <Box as="form" onSubmit={handleSubmit}>
      <Label>Video</Label>
      <Input type="file" accept="video/*" onChange={handleFileChange} />
      <Button type="button" onClick={handleSubmit}>Upload</Button>
    </Box>
  );
};

export default VideoUploadEditComponent;
