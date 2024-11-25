import React, { useEffect, useState } from 'react';
import {
    Header, CheckBox, TableBody, DropDown, DropDownTrigger, DropDownMenu, DropDownItem, Badge, Icon, Table, TableRow, TableCell, Box, TableCaption, Button, Text, TableHead,
} from '@adminjs/design-system';
import type ExerciseLog from 'src/db/models/exerciseLog.js';
import type User from 'src/db/models/user.js';
import axios from 'axios';
import Exercise from 'src/db/models/exercise.js';

type ExerciseLogExtend = ExerciseLog & { checked: boolean, Exercise: Exercise }

const UserDetail = (props) => {
    const [exerciseLogList, setExerciseLogList] = useState<Array<ExerciseLogExtend>>([]);
    const getData = async () => {
        const { data: mDetail }: { data: User & { ExerciseLogs: Array<ExerciseLogExtend> } } = await axios.get(`/user/detail/${props.record.id}`);
        setExerciseLogList(mDetail.ExerciseLogs);
    };
    useEffect(() => {
        getData();
    }, []);

    return (
        <Box>
            <div>
                <div
                    style={{
                        alignItems: 'center',
                        marginTop: 20,
                        marginBottom: 20,
                        display: 'flex',
                        justifyContent: 'space-between',
                        margin: '20px 0',
                    }}
                >
                    <Button
                        color="secondary"
                        variant="contained"
                        onClick={() => {
                            axios.get(`/user/sendResetPasswordEmail/${props.record.id}`).then(() => {
                                alert('A password reset link has been sent to the user');
                            });
                        }}
                    >
                        Reset Password
                    </Button>
                    <Header.H1 style={{ margin: 0 }}>Exercise Log</Header.H1>
                    <div
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                        }}
                    >
                        <Button
                            color="secondary"
                            variant="contained"
                            onClick={() => {
                                location.href = `/user/exportActivies?ID=${props.record.id}`;
                            }}
                        >
                            Export Activities
                        </Button>
                        <Button
                            variant="text"
                            onClick={() => location.href = '/admin/resources/exercise_log'}
                        >
                            <Icon icon="Filter" color="#000" />
                        </Button>
                    </div>
                </div>
                <Table style={{ textAlign: 'center' }}>
                    <TableHead>
                        <TableRow>
                            <TableCell>ID</TableCell>
                            <TableCell>Title</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {exerciseLogList.map((item, i) => (
                            <TableRow
                                key={i}
                            >
                                {/* <TableCell align="center">{item.ID}</TableCell>
                                <TableCell align="center">{item.Exercise?.Caption}</TableCell> */}
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </div>
        </Box>
    );
};

export default UserDetail;
