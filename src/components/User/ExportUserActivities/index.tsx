import React from 'react';
import { Button } from '@adminjs/design-system';

const ExportActivities = () => (
    <Button
        onClick={() => {
            location.href = '/user/exportActivies';
        }}
    >
        Export Xlsx
    </Button>
);

export default ExportActivities;
