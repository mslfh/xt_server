import React from 'react';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';

const localizer = momentLocalizer(moment);

interface FormattedEvent {
    id: number;
    title: string;
    start: Date;
    end: Date;
}

interface UserEventProps {
    events: FormattedEvent[];
}
const UserEvent: React.FC<UserEventProps> = ({ events }) => (
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
                events={events}
                startAccessor="start"
                endAccessor="end"
                selectable
                onSelectSlot={() => {
                    window.location.href = '/admin/resources/user_event/actions/new';
                }}
                onSelectEvent={(event) => {
                    window.location.href = `/admin/resources/user_event/records/${event.id}/show`;
                }}
            />
        </div>
    </div>
);

export default UserEvent;
