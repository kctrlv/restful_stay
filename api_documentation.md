API Documentation

Paths:

GET /api/v1/trips/:trip_id/review

Summary:
Review specifics

Description:
This will show the specific review for a trip.

Parameters:
api_key

Responses:
200 - Specific review for trip on trip show page
---------------------
POST /api/v1/trips/:trip_id/review

Summary:
CREATE action for a new review

Description:
This will create a new review for a specific trip.

Parameters:
api_key, subject, body

Responses:
200 - POST to CREATE
---------------------
PATCH /api/v1/trips/:trip_id/review

Summary: UPDATE action for editing a review

Description: This will update an existing review for a specific trip.

Parameters: api_key, subject, body

Responses:
200 - PATCH to UPDATE
---------------------
DELETE /api/v1/trips/:trip_id/review

Summary: DESTROY action for deleting an existing review.

Description: This will delete an existing review for a specific trip.

Parameters: api_key

Responses:
200 - Review index page
