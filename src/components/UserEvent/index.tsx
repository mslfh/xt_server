import React, { useEffect, useState } from 'react';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';
import axios from 'axios';

import UserEvents from '../../db/models/userEvents.js';

const localizer = momentLocalizer(moment);
const UserEvent = () => {
    const [events, setEvents] = useState<UserEvents[]>([]);

    useEffect(() => {
        axios.get('/userEvent/getAllList').then((res) => {
            setEvents(res.data);
        });
    }, []);

    return (
        <div>
            <div style={{
                height: 800,
                padding: 20,
                boxSizing: 'border-box',
                background: '#fff',
            }}
            >
                <Calendar
                    localizer={localizer}
                    // events={events.map((item) => ({
                    //     id: item.ID,
                    //     title: `[${item.User.Username}]${item.ExerciseCategory.Title}`,
                    //     start: moment(item.Date).toDate(),
                    //     end: moment(item.Date).toDate(),
                    // }))}
                    startAccessor="start"
                    endAccessor="end"
                    selectable
                    onSelectSlot={() => {
                        location.href = '/admin/resources/user_event/actions/new';
                    }}
                    onSelectEvent={(event) => {
                        // location.href = `/admin/resources/user_event/records/${event.id}/show`;
                    }}
                />
            </div>
        </div>
    );
};

export default UserEvent;
