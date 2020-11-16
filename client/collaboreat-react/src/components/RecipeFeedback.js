import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

import GetPerson from './Person';

export default function GetFeedback({ feedback }) {
  return (
    <>
    <tr key={feedback.feedbackId}>
        <td><GetPerson id={feedback.userId} /></td>
        <td>{feedback.feedbackComment}</td>
        <td>{feedback.feedbackRating} / 5</td>
    </tr>
    </>
  );
}