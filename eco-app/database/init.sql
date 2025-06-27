-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE Users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(75),
    pfp_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    path_to_post VARCHAR(255),
    caption VARCHAR(500),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES Posts(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, post_id) -- prevents duplicate likes
);

CREATE TABLE Comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    body VARCHAR(500) NOT NULL,
    user_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES Posts(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Friends (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    friend_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'accepted', 'rejected')),
    UNIQUE(user_id, friend_id)
);

CREATE TABLE Eco_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    activity_type VARCHAR NOT NULL,
    metadata JSONB,
    logged_at TIMESTAMP DEFAULT NOW()
);
