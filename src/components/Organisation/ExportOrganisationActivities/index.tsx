import React from 'react';
import { Button } from '@adminjs/design-system';

const ExportActivities = () => {
  return (
    <Button
      onClick={() => {
        location.href = '/department/exportActivies'
      }} 
    >
      Export Xlsx
    </Button>
  );
}

export default ExportActivities;
