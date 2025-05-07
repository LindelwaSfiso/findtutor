# Find Tutor API Documentation

## Overview
This document provides comprehensive documentation for the Find Tutor API, a platform connecting students with tutors in Eswatini. The API is built using Django REST Framework and follows RESTful principles.

## Base URL
```
/api/v1/
```

## Authentication
All endpoints except for subject listing require authentication. The API uses JWT token-based authentication.

### Headers
```
Authorization: Bearer <your_access_token>
```

## API Endpoints

### Subjects

#### List All Subjects
```http
GET /api/v1/subjects/
```
Returns a list of all available subjects.

**Query Parameters:**
- `search`: Search subjects by name or description
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 10,
    "next": "http://api/v1/subjects/?page=2",
    "previous": null,
    "results": [
        {
            "id": 1,
            "name": "Mathematics",
            "description": "Basic to advanced mathematics"
        }
    ]
}
```

#### Get Subject Details
```http
GET /api/v1/subjects/{id}/
```
Returns detailed information about a specific subject.

**Response:**
```json
{
    "id": 1,
    "name": "Mathematics",
    "description": "Basic to advanced mathematics"
}
```

### User Profiles

#### List User Profiles
```http
GET /api/v1/profiles/
```
Returns a list of user profiles. Only returns the authenticated user's profile.

**Response:**
```json
{
    "id": 1,
    "user": {
        "id": 1,
        "username": "john_doe",
        "email": "john@example.com",
        "first_name": "John",
        "last_name": "Doe"
    },
    "user_type": "student",
    "phone_number": "+26812345678",
    "city": "Mbabane",
    "address": "123 Main St",
    "profile_picture": "profile_pictures/default.jpg",
    "bio": "Student looking for math tutor"
}
```

#### Create User Profile
```http
POST /api/v1/profiles/
```
Creates a new user profile.

**Request Body:**
```json
{
    "user": {
        "username": "john_doe",
        "email": "john@example.com",
        "password": "securepassword",
        "first_name": "John",
        "last_name": "Doe"
    },
    "user_type": "student",
    "phone_number": "+26812345678",
    "city": "Mbabane",
    "address": "123 Main St",
    "bio": "Student looking for math tutor"
}
```

### Tutor Profiles

#### List Tutors
```http
GET /api/v1/tutors/
```
Returns a list of tutor profiles with filtering options.

**Query Parameters:**
- `subject`: Filter by subject name
- `min_price`: Minimum hourly rate
- `max_price`: Maximum hourly rate
- `is_available`: Filter by availability (true/false)
- `is_verified`: Filter by verification status (true/false)
- `search`: Search by name or qualifications
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 5,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "user_profile": {
                "id": 1,
                "user": {
                    "id": 1,
                    "username": "tutor_jane",
                    "email": "jane@example.com",
                    "first_name": "Jane",
                    "last_name": "Smith"
                }
            },
            "subjects": [
                {
                    "id": 1,
                    "name": "Mathematics"
                }
            ],
            "education_level": "masters",
            "qualifications": "MSc in Mathematics",
            "experience_years": 5,
            "hourly_rate": "150.00",
            "availability": "Available on weekdays",
            "is_available": true,
            "is_verified": true,
            "contact_email": "jane@example.com",
            "contact_phone": "+26812345678",
            "whatsapp_number": "+26812345678",
            "website": "https://janetutor.com"
        }
    ]
}
```

#### Get Current Tutor Profile
```http
GET /api/v1/tutors/me/
```
Returns the authenticated tutor's profile.

#### Update Tutor Profile
```http
PATCH /api/v1/tutors/me/
```
Updates the tutor's profile information.

**Request Body:**
```json
{
    "availability": "Available on weekdays",
    "is_available": true,
    "contact_email": "jane@example.com",
    "contact_phone": "+26812345678",
    "whatsapp_number": "+26812345678",
    "website": "https://janetutor.com"
}
```

### Student Profiles

#### List Student Profiles
```http
GET /api/v1/students/
```
Returns a list of student profiles. Only returns the authenticated student's profile.

**Response:**
```json
{
    "id": 1,
    "user_profile": {
        "id": 1,
        "user": {
            "id": 1,
            "username": "student_john",
            "email": "john@example.com",
            "first_name": "John",
            "last_name": "Doe"
        }
    },
    "education_level": "high_school",
    "subjects_of_interest": [
        {
            "id": 1,
            "name": "Mathematics"
        }
    ],
    "grade_level": "Form 4",
    "school_name": "Mbabane High School"
}
```

#### Get Current Student Profile
```http
GET /api/v1/students/me/
```
Returns the authenticated student's profile.

### Reviews

#### List Reviews
```http
GET /api/v1/reviews/
```
Returns a list of reviews for a tutor.

**Query Parameters:**
- `tutor`: Filter by tutor ID
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "tutor_profile": 1,
            "user_profile": 2,
            "rating": 5,
            "comment": "Excellent tutor!",
            "created_at": "2024-03-15T10:00:00Z"
        }
    ]
}
```

### Forum

#### List Forums
```http
GET /api/v1/forum/forums/
```
Returns a list of forums.

**Query Parameters:**
- `search`: Search forums by name or description
- `is_private`: Filter by privacy status
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "name": "Mathematics Help",
            "description": "Forum for mathematics discussions",
            "admin": {
                "id": 1,
                "user": {
                    "username": "admin_jane",
                    "first_name": "Jane",
                    "last_name": "Smith"
                }
            },
            "is_private": false,
            "members_count": 10,
            "followers_count": 15,
            "posts_count": 5,
            "created_at": "2024-03-15T10:00:00Z"
        }
    ]
}
```

#### Create Forum
```http
POST /api/v1/forum/forums/
```
Creates a new forum.

**Request Body:**
```json
{
    "name": "Mathematics Help",
    "description": "Forum for mathematics discussions",
    "is_private": false
}
```

#### Join Forum
```http
POST /api/v1/forum/forums/{id}/join/
```
Request to join a forum. For private forums, this creates a pending membership request.

#### Leave Forum
```http
POST /api/v1/forum/forums/{id}/leave/
```
Leave a forum.

#### Follow Forum
```http
POST /api/v1/forum/forums/{id}/follow/
```
Follow a forum to receive updates.

#### Unfollow Forum
```http
POST /api/v1/forum/forums/{id}/unfollow/
```
Unfollow a forum.

### Forum Posts

#### List Posts
```http
GET /api/v1/forum/posts/
```
Returns a list of posts in a forum.

**Query Parameters:**
- `forum`: Filter by forum ID
- `post_type`: Filter by post type (question/tutorial/discussion)
- `search`: Search posts by title or content
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "forum": 1,
            "author": {
                "id": 1,
                "user": {
                    "username": "student_john",
                    "first_name": "John",
                    "last_name": "Doe"
                }
            },
            "title": "Help with Calculus",
            "content": "I need help understanding derivatives...",
            "post_type": "question",
            "images": [
                {
                    "id": 1,
                    "image": "forums/posts/derivative.jpg",
                    "caption": "Derivative problem"
                }
            ],
            "links": [
                {
                    "id": 1,
                    "url": "https://example.com/calculus",
                    "title": "Calculus Tutorial",
                    "description": "Helpful resource"
                }
            ],
            "comments": [
                {
                    "id": 1,
                    "author": {
                        "id": 2,
                        "user": {
                            "username": "tutor_jane",
                            "first_name": "Jane",
                            "last_name": "Smith"
                        }
                    },
                    "content": "Let me help you with that...",
                    "created_at": "2024-03-15T11:00:00Z"
                }
            ],
            "likes_count": 5,
            "created_at": "2024-03-15T10:00:00Z"
        }
    ]
}
```

#### Create Post
```http
POST /api/v1/forum/posts/
```
Creates a new post in a forum.

**Request Body:**
```json
{
    "forum": 1,
    "title": "Help with Calculus",
    "content": "I need help understanding derivatives..."
    "post_type": "question"
}
```

#### Like Post
```http
POST /api/v1/forum/posts/{id}/like/
```
Like a post.

#### Unlike Post
```http
POST /api/v1/forum/posts/{id}/unlike/
```
Unlike a post.

### Forum Comments

#### List Comments
```http
GET /api/v1/forum/comments/
```
Returns a list of comments for a post.

**Query Parameters:**
- `post`: Filter by post ID
- `page`: Page number for pagination
- `page_size`: Number of items per page

**Response:**
```json
{
    "count": 2,
    "next": null,
    "previous": null,
    "results": [
        {
            "id": 1,
            "post": 1,
            "author": {
                "id": 2,
                "user": {
                    "username": "tutor_jane",
                    "first_name": "Jane",
                    "last_name": "Smith"
                }
            },
            "content": "Let me help you with that...",
            "parent": null,
            "replies": [
                {
                    "id": 2,
                    "author": {
                        "id": 1,
                        "user": {
                            "username": "student_john",
                            "first_name": "John",
                            "last_name": "Doe"
                        }
                    },
                    "content": "Thank you!",
                    "created_at": "2024-03-15T12:00:00Z"
                }
            ],
            "likes_count": 3,
            "created_at": "2024-03-15T11:00:00Z"
        }
    ]
}
```

#### Create Comment
```http
POST /api/v1/forum/comments/
```
Creates a new comment on a post.

**Request Body:**
```json
{
    "post": 1,
    "content": "Let me help you with that...",
    "parent": null
}
```

#### Like Comment
```http
POST /api/v1/forum/comments/{id}/like/
```
Like a comment.

#### Unlike Comment
```http
POST /api/v1/forum/comments/{id}/unlike/
```
Unlike a comment.

## Error Responses

The API uses standard HTTP status codes and returns error messages in the following format:

```json
{
    "detail": "Error message here"
}
```

Common status codes:
- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Internal Server Error

## Rate Limiting

The API implements rate limiting to prevent abuse. The current limits are:
- 100 requests per hour for authenticated users
- 20 requests per hour for unauthenticated users

## Pagination

All list endpoints support pagination with the following query parameters:
- `page`: Page number (default: 1)
- `page_size`: Items per page (default: 10, max: 100)

## File Uploads

For profile pictures and other file uploads, use multipart/form-data content type. The maximum file size is 5MB.

## Best Practices

1. Always include the Authorization header for authenticated requests
2. Use appropriate HTTP methods (GET, POST, PUT, PATCH, DELETE)
3. Handle rate limiting by implementing exponential backoff
4. Implement proper error handling for all API calls
5. Use pagination for large data sets
6. Cache responses when appropriate
7. Validate all input data before sending requests 