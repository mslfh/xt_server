import { Button, Select } from '@adminjs/design-system';
import axios from 'axios';
import React, { useEffect, useState } from 'react';

import type Organisation from '../../../db/models/organisation.js';

const DepartmentMove = ({ record, records }) => {
  const [selectOrganisation, setSelectOrganisation] = useState<{ value: string }>();
  const [organisationList, setOrganisationList] = useState<Organisation[]>([]);

  useEffect(() => {
    axios.get('/organisation/getAllList').then((res) => {
      setOrganisationList(res.data);
    });
  }, []);

  return (
    <div>
      <Select
        placeholder="Select Organisation"
        value={selectOrganisation}
        onChange={(item) => setSelectOrganisation(item)}
        options={organisationList.map((item) => ({
          label: `[${item.ShortName}]${item.LongName}`,
          value: item.ID,
        }))}
      />
      <div style={{ marginTop: 20 }}>
        <Button
          size="lg"
          color="secondary"
          variant="contained"
          onClick={async () => {
            try {
              const ids = [];
              if (record) {
                ids.push(record.id);
              } else if (records) {
                ids.push(...records.map((item) => item.id));
              }
              await axios.post('/department/moveOrganisation', {
                ids,
                organisationId: selectOrganisation.value,
              });
              alert('Move success');
              history.back();
            } catch {
              alert('Move failure');
            }
          }}
        >
          Move
        </Button>
      </div>
    </div>
  );
};

export default DepartmentMove;
