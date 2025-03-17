-- Step 1: Create the Database
CREATE DATABASE sg47_AdCampaignDB;
USE sg47_AdCampaignDB;

-- Step 2: Create Tables (without normalization)
-- Campaign Table
CREATE TABLE Campaign (
    Id VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget FLOAT NOT NULL,
    Status VARCHAR(50) NOT NULL
);

-- Ad Group Table
CREATE TABLE AdGroup (
    Id VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    BidStrategy VARCHAR(100) NOT NULL,
    CampaignId VARCHAR(50) NOT NULL,
    FOREIGN KEY (CampaignId) REFERENCES Campaign(Id) ON DELETE CASCADE
);

-- Ad Table
CREATE TABLE Ad (
    Id VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50) NOT NULL CHECK (Type IN ('Text', 'Image', 'Video')),
    Content TEXT NOT NULL,
    DestinationUrl TEXT NOT NULL,
    CampaignId VARCHAR(50) NOT NULL,
    FOREIGN KEY (CampaignId) REFERENCES Campaign(Id) ON DELETE CASCADE
);

-- Keyword Table
CREATE TABLE Keyword (
    Id VARCHAR(50) PRIMARY KEY,
    Text VARCHAR(255) NOT NULL,
    MatchType VARCHAR(50) NOT NULL CHECK (MatchType IN ('Broad', 'Phrase', 'Exact')),
    AdGroupId VARCHAR(50) NOT NULL,
    FOREIGN KEY (AdGroupId) REFERENCES AdGroup(Id) ON DELETE CASCADE
);

-- Audience Table
CREATE TABLE Audience (
    Id VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    TargetingCriteria TEXT NOT NULL
);

-- Ad Placement Table
CREATE TABLE AdPlacement (
    Id VARCHAR(50) PRIMARY KEY,
    Type VARCHAR(50) NOT NULL CHECK (Type IN ('Search', 'Display', 'Video')),
    WebsiteOrAppName VARCHAR(255) NOT NULL,
    AdId VARCHAR(50) NOT NULL,
    FOREIGN KEY (AdId) REFERENCES Ad(Id) ON DELETE CASCADE
);

-- Performance Metrics Table
CREATE TABLE PerformanceMetrics (
    Id VARCHAR(50) PRIMARY KEY,
    Impressions INT NOT NULL,
    Clicks INT NOT NULL,
    Conversions INT NOT NULL,
    CostPerClick FLOAT NOT NULL,
    AdId VARCHAR(50) NOT NULL,
    FOREIGN KEY (AdId) REFERENCES Ad(Id) ON DELETE CASCADE
);

-- Budget Allocation Table
CREATE TABLE BudgetAllocation (
    Id VARCHAR(50) PRIMARY KEY,
    AllocatedAmount FLOAT NOT NULL,
    SpentAmount FLOAT NOT NULL,
    CampaignId VARCHAR(50) NOT NULL,
    FOREIGN KEY (CampaignId) REFERENCES Campaign(Id) ON DELETE CASCADE
);

-- Junction Table: Ad Group - Keyword (Many-to-Many)
CREATE TABLE AdGroupKeyword (
    AdGroupId VARCHAR(50),
    KeywordId VARCHAR(50),
    PRIMARY KEY (AdGroupId, KeywordId),
    FOREIGN KEY (AdGroupId) REFERENCES AdGroup(Id) ON DELETE CASCADE,
    FOREIGN KEY (KeywordId) REFERENCES Keyword(Id) ON DELETE CASCADE
);

-- Junction Table: Campaign - Audience (Many-to-Many)
CREATE TABLE CampaignAudience (
    CampaignId VARCHAR(50),
    AudienceId VARCHAR(50),
    PRIMARY KEY (CampaignId, AudienceId),
    FOREIGN KEY (CampaignId) REFERENCES Campaign(Id) ON DELETE CASCADE,
    FOREIGN KEY (AudienceId) REFERENCES Audience(Id) ON DELETE CASCADE
);

-- Junction Table: Ad - Placement (Many-to-Many)
CREATE TABLE AdPlacementTracking (
    AdId VARCHAR(50),
    PlacementId VARCHAR(50),
    PRIMARY KEY (AdId, PlacementId),
    FOREIGN KEY (AdId) REFERENCES Ad(Id) ON DELETE CASCADE,
    FOREIGN KEY (PlacementId) REFERENCES AdPlacement(Id) ON DELETE CASCADE
);

-- Step 3: Insert Data into the Tables
-- Campaign Table
INSERT INTO Campaign VALUES
('C001', 'Spring Sale', '2024-01-01', '2024-03-31', 5000.00, 'Active'),
('C002', 'Winter Clearance', '2024-02-01', '2024-04-30', 7000.00, 'Active'),
('C003', 'Tech Deals', '2024-01-15', '2024-03-15', 4500.00, 'Inactive'),
('C004', 'Back to School', '2024-06-01', '2024-08-31', 8000.00, 'Active'),
('C005', 'Black Friday Special', '2024-11-01', '2024-11-30', 12000.00, 'Upcoming'),
('C006', 'Summer Bonanza', '2024-05-01', '2024-07-31', 6000.00, 'Active'),
('C007', 'Cyber Monday', '2024-11-25', '2024-11-30', 10000.00, 'Upcoming'),
('C008', 'New Year Celebration', '2024-12-15', '2025-01-15', 9000.00, 'Upcoming'),
('C009', 'Fashion Week Sale', '2024-09-01', '2024-09-30', 7500.00, 'Active'),
('C010', 'Gadget Festival', '2024-10-01', '2024-10-31', 8500.00, 'Active'),
('C011', 'Automotive Discounts', '2024-03-01', '2024-05-31', 6200.00, 'Active'),
('C012', 'Home Essentials Sale', '2024-06-15', '2024-08-15', 7800.00, 'Active'),
('C013', 'Fitness Frenzy', '2024-04-01', '2024-06-30', 7200.00, 'Inactive'),
('C014', 'Beauty Bonanza', '2024-07-01', '2024-09-30', 6700.00, 'Active'),
('C015', 'Gaming Discounts', '2024-08-01', '2024-08-31', 5000.00, 'Active'),
('C016', 'Health & Wellness', '2024-03-01', '2024-06-01', 6500.00, 'Inactive'),
('C017', 'Valentine’s Day Special', '2024-02-01', '2024-02-14', 4500.00, 'Active'),
('C018', 'Pet Supplies Sale', '2024-05-01', '2024-07-31', 7100.00, 'Active'),
('C019', 'Office Essentials Sale', '2024-09-01', '2024-10-31', 7300.00, 'Active'),
('C020', 'Music Lovers Campaign', '2024-06-01', '2024-07-31', 6200.00, 'Active'),
('C021', 'Luxury Brands Fest', '2024-11-01', '2024-12-31', 15000.00, 'Upcoming'),
('C022', 'Eco-Friendly Products', '2024-07-01', '2024-09-30', 6800.00, 'Active'),
('C023', 'Baby Products Sale', '2024-04-01', '2024-06-30', 7000.00, 'Active'),
('C024', 'B2B Promotions', '2024-03-01', '2024-05-31', 9000.00, 'Active'),
('C025', 'Freelancer Tools Discount', '2024-06-15', '2024-08-15', 8000.00, 'Inactive'),
('C026', 'Wedding Season Sale', '2024-09-01', '2024-10-15', 7500.00, 'Active'),
('C027', 'End of Season Sale', '2024-12-01', '2024-12-31', 9200.00, 'Upcoming'),
('C028', 'AI & Tech Innovations', '2024-10-01', '2024-11-30', 9500.00, 'Active'),
('C029', 'Small Business Growth', '2024-02-01', '2024-04-30', 8500.00, 'Active'),
('C030', 'Influencer Deals', '2024-07-01', '2024-08-31', 7200.00, 'Active'),
('C031', 'Student Discounts', '2024-05-01', '2024-06-30', 5800.00, 'Active'),
('C032', 'Sports Fan Campaign', '2024-08-01', '2024-09-30', 6300.00, 'Active'),
('C033', 'Backyard Makeover', '2024-03-01', '2024-05-15', 7100.00, 'Active'),
('C034', 'Sustainable Living Sale', '2024-09-01', '2024-11-01', 8200.00, 'Active'),
('C035', 'Frequent Flyer Discounts', '2024-06-01', '2024-08-01', 9700.00, 'Active'),
('C036', 'Exclusive VIP Offers', '2024-11-01', '2024-12-31', 14000.00, 'Upcoming'),
('C037', 'Mother’s Day Specials', '2024-04-15', '2024-05-15', 6000.00, 'Active'),
('C038', 'Father’s Day Deals', '2024-05-15', '2024-06-15', 6300.00, 'Active'),
('C039', 'Eco-Conscious Fashion', '2024-07-01', '2024-09-01', 7500.00, 'Active'),
('C040', 'Freelancer Deals', '2024-08-01', '2024-09-15', 6900.00, 'Active'),
('C041', 'Laptop Discounts', '2024-03-01', '2024-05-01', 8800.00, 'Active'),
('C042', 'Educational Resources', '2024-02-01', '2024-03-31', 5800.00, 'Active'),
('C043', 'Remote Work Essentials', '2024-04-01', '2024-06-01', 7700.00, 'Active'),
('C044', 'Streaming Services Sale', '2024-06-01', '2024-07-31', 8100.00, 'Active'),
('C045', 'Organic Food Specials', '2024-09-01', '2024-10-31', 8600.00, 'Active'),
('C046', 'Smart Home Upgrades', '2024-10-01', '2024-12-01', 9400.00, 'Active'),
('C047', 'E-Sports Promotions', '2024-07-01', '2024-08-31', 7000.00, 'Active'),
('C048', 'Auto Parts Discounts', '2024-05-01', '2024-07-01', 7500.00, 'Active'),
('C049', 'Winter Accessories', '2024-11-01', '2024-12-31', 9900.00, 'Upcoming'),
('C050', 'Year-End Clearance', '2024-12-15', '2025-01-15', 10500.00, 'Upcoming');


-- Ad Group Table
INSERT INTO AdGroup VALUES
('AG001', 'High Bid Strategy', 'Maximize Clicks', 'C001'),
('AG002', 'Budget Friendly Ads', 'Target CPA', 'C002'),
('AG003', 'Premium Product Ads', 'ROAS Optimization', 'C003'),
('AG004', 'Seasonal Offers', 'Enhanced CPC', 'C004'),
('AG005', 'Discount Focused', 'Manual CPC', 'C005'),
('AG006', 'Fashion Deals', 'Maximize Conversions', 'C006'),
('AG007', 'Tech Enthusiasts', 'ROAS Optimization', 'C007'),
('AG008', 'Automotive Promotions', 'Enhanced CPC', 'C008'),
('AG009', 'Travel Campaigns', 'Target CPA', 'C009'),
('AG010', 'E-commerce Growth', 'Maximize Clicks', 'C010'),
('AG011', 'Health & Wellness', 'Maximize Conversions', 'C011'),
('AG012', 'Fitness Enthusiasts', 'Target ROAS', 'C012'),
('AG013', 'Home Improvement', 'Enhanced CPC', 'C013'),
('AG014', 'Luxury Fashion', 'Manual CPC', 'C014'),
('AG015', 'Electronics Discounts', 'Target CPA', 'C015'),
('AG016', 'Pet Supplies', 'Maximize Clicks', 'C016'),
('AG017', 'Gaming Accessories', 'ROAS Optimization', 'C017'),
('AG018', 'Food & Beverages', 'Target CPA', 'C018'),
('AG019', 'B2B Marketing', 'Enhanced CPC', 'C019'),
('AG020', 'Home Decor', 'Maximize Conversions', 'C020'),
('AG021', 'Kids Fashion', 'Manual CPC', 'C021'),
('AG022', 'Music Equipment', 'Maximize Clicks', 'C022'),
('AG023', 'Smart Gadgets', 'ROAS Optimization', 'C023'),
('AG024', 'Outdoor Adventures', 'Target CPA', 'C024'),
('AG025', 'Beauty & Skincare', 'Enhanced CPC', 'C025'),
('AG026', 'Automotive Accessories', 'Maximize Clicks', 'C026'),
('AG027', 'Mobile Accessories', 'Target ROAS', 'C027'),
('AG028', 'Streaming Services', 'Manual CPC', 'C028'),
('AG029', 'Education & Learning', 'Maximize Conversions', 'C029'),
('AG030', 'Subscription Boxes', 'Enhanced CPC', 'C030'),
('AG031', 'Handmade Crafts', 'Target CPA', 'C031'),
('AG032', 'Wedding Services', 'ROAS Optimization', 'C032'),
('AG033', 'Freelance Services', 'Manual CPC', 'C033'),
('AG034', 'Real Estate Promotions', 'Maximize Clicks', 'C034'),
('AG035', 'Luxury Travel', 'Target ROAS', 'C035'),
('AG036', 'Grocery Discounts', 'Enhanced CPC', 'C036'),
('AG037', 'Personal Finance', 'Target CPA', 'C037'),
('AG038', 'Green Energy Solutions', 'ROAS Optimization', 'C038'),
('AG039', 'Cybersecurity Products', 'Maximize Conversions', 'C039'),
('AG040', 'Insurance Offers', 'Target CPA', 'C040'),
('AG041', 'DIY & Crafting', 'Manual CPC', 'C041'),
('AG042', 'Local Businesses', 'Enhanced CPC', 'C042'),
('AG043', 'Job Listings', 'Maximize Clicks', 'C043'),
('AG044', 'Fitness Programs', 'Target ROAS', 'C044'),
('AG045', 'Charity & Nonprofits', 'ROAS Optimization', 'C045'),
('AG046', 'Event Promotions', 'Target CPA', 'C046'),
('AG047', 'Luxury Cars', 'Maximize Conversions', 'C047'),
('AG048', 'AI & Tech Innovations', 'Enhanced CPC', 'C048'),
('AG049', 'Holiday Specials', 'Manual CPC', 'C049'),
('AG050', 'Business Software', 'Target ROAS', 'C050');

-- Ad Table
INSERT INTO Ad VALUES
('A001', 'Spring Ad 1', 'Text', 'Best Spring Deals!', 'https://example.com/spring', 'C001'),
('A002', 'Spring Ad 2', 'Image', 'Amazing Discounts!', 'https://example.com/spring', 'C001'),
('A003', 'Winter Sale', 'Video', 'Biggest Winter Sale!', 'https://example.com/winter', 'C002'),
('A004', 'Tech Ad', 'Text', 'Latest Gadgets Here!', 'https://example.com/tech', 'C003'),
('A005', 'School Essentials', 'Image', 'Back-to-School Savings!', 'https://example.com/school', 'C004'),
('A006', 'Summer Collection', 'Image', 'New Summer Arrivals!', 'https://example.com/summer', 'C006'),
('A007', 'Gaming Gear Sale', 'Video', 'Top Gaming Accessories!', 'https://example.com/gaming', 'C007'),
('A008', 'Car Accessories', 'Text', 'Upgrade Your Ride!', 'https://example.com/auto', 'C008'),
('A009', 'Flight Deals', 'Image', 'Discounted Flights!', 'https://example.com/travel', 'C009'),
('A010', 'Online Shopping Festival', 'Video', 'Mega Sale Event!', 'https://example.com/ecommerce', 'C010'),
('A011', 'Fitness Ad', 'Text', 'Stay Fit with Top Gear!', 'https://example.com/fitness', 'C011'),
('A012', 'Luxury Watches', 'Image', 'Timeless Elegance!', 'https://example.com/watches', 'C012'),
('A013', 'Pet Supplies', 'Video', 'Everything for Your Pet!', 'https://example.com/pets', 'C013'),
('A014', 'Beauty Products', 'Text', 'Glow Like Never Before!', 'https://example.com/beauty', 'C014'),
('A015', 'Home Decor', 'Image', 'Stylish Interiors Await!', 'https://example.com/home', 'C015'),
('A016', 'Smartphones Sale', 'Text', 'Latest Phones at Best Prices!', 'https://example.com/mobiles', 'C016'),
('A017', 'Wedding Specials', 'Image', 'Make Your Day Memorable!', 'https://example.com/wedding', 'C017'),
('A018', 'Movie Subscriptions', 'Video', 'Unlimited Entertainment!', 'https://example.com/movies', 'C018'),
('A019', 'Healthy Eating', 'Text', 'Fresh Organic Choices!', 'https://example.com/organic', 'C019'),
('A020', 'Outdoor Camping', 'Image', 'Gear Up for Adventure!', 'https://example.com/camping', 'C020'),
('A021', 'Automobile Ad', 'Video', 'Experience the Thrill!', 'https://example.com/cars', 'C021'),
('A022', 'Book Sale', 'Text', 'Bestsellers at Huge Discounts!', 'https://example.com/books', 'C022'),
('A023', 'Educational Courses', 'Image', 'Upgrade Your Skills!', 'https://example.com/learning', 'C023'),
('A024', 'Furniture Discounts', 'Text', 'Upgrade Your Living Space!', 'https://example.com/furniture', 'C024'),
('A025', 'Gourmet Foods', 'Image', 'Taste the Best!', 'https://example.com/gourmet', 'C025'),
('A026', 'Photography Gear', 'Video', 'Capture Your Best Moments!', 'https://example.com/photography', 'C026'),
('A027', 'Kids Toys Sale', 'Text', 'Fun for All Ages!', 'https://example.com/toys', 'C027'),
('A028', 'Music Instruments', 'Image', 'Play Your Heart Out!', 'https://example.com/music', 'C028'),
('A029', 'Gadgets & Accessories', 'Text', 'Latest Tech Trends!', 'https://example.com/gadgets', 'C029'),
('A030', 'Sports Equipment', 'Image', 'Gear Up for Victory!', 'https://example.com/sports', 'C030'),
('A031', 'Grocery Deals', 'Text', 'Fresh and Affordable!', 'https://example.com/grocery', 'C031'),
('A032', 'Streaming Services', 'Video', 'Watch Your Favorites!', 'https://example.com/streaming', 'C032'),
('A033', 'Gift Ideas', 'Image', 'Find the Perfect Gift!', 'https://example.com/gifts', 'C033'),
('A034', 'Travel Insurance', 'Text', 'Travel with Peace of Mind!', 'https://example.com/insurance', 'C034'),
('A035', 'DIY Tools', 'Image', 'Get Creative with DIY!', 'https://example.com/diy', 'C035'),
('A036', 'Financial Services', 'Text', 'Secure Your Future!', 'https://example.com/finance', 'C036'),
('A037', 'Dating App', 'Image', 'Find Your Match!', 'https://example.com/dating', 'C037'),
('A038', 'Freelance Work', 'Text', 'Find Your Next Gig!', 'https://example.com/freelance', 'C038'),
('A039', 'Mental Health Support', 'Image', 'Prioritize Your Well-being!', 'https://example.com/mentalhealth', 'C039'),
('A040', 'Career Coaching', 'Text', 'Boost Your Career!', 'https://example.com/career', 'C040'),
('A041', 'Electronics Clearance', 'Video', 'Huge Discounts Await!', 'https://example.com/electronics', 'C041'),
('A042', 'Gardening Supplies', 'Image', 'Grow Your Own Garden!', 'https://example.com/gardening', 'C042'),
('A043', 'Subscription Boxes', 'Text', 'Exciting Monthly Surprises!', 'https://example.com/subscriptions', 'C043'),
('A044', 'Virtual Reality', 'Image', 'Step into Another World!', 'https://example.com/vr', 'C044'),
('A045', 'Cycling Gear', 'Text', 'Ride with Comfort!', 'https://example.com/cycling', 'C045'),
('A046', 'Yoga Essentials', 'Image', 'Balance Your Life!', 'https://example.com/yoga', 'C046'),
('A047', 'Custom Merchandise', 'Text', 'Make It Yours!', 'https://example.com/custom', 'C047'),
('A048', 'Tech Startups', 'Image', 'Invest in the Future!', 'https://example.com/startups', 'C048'),
('A049', 'Online Coaching', 'Text', 'Learn Anytime, Anywhere!', 'https://example.com/coaching', 'C049'),
('A050', 'Luxury Travel', 'Video', 'Experience the Best!', 'https://example.com/luxurytravel', 'C050');


-- Keyword Table
INSERT INTO Keyword VALUES
('K001', 'discount offers', 'Broad', 'AG001'),
('K002', 'best deals', 'Phrase', 'AG001'),
('K003', 'tech gadgets', 'Exact', 'AG003'),
('K004', 'school supplies sale', 'Broad', 'AG004'),
('K005', 'Black Friday discounts', 'Exact', 'AG005'),
('K006', 'holiday discounts', 'Broad', 'AG006'),
('K007', 'cheap flights', 'Phrase', 'AG007'),
('K008', 'luxury watches', 'Exact', 'AG008'),
('K009', 'organic skincare', 'Broad', 'AG009'),
('K010', 'gaming laptops sale', 'Phrase', 'AG010'),
('K011', 'best smartphone deals', 'Exact', 'AG011'),
('K012', 'home decor ideas', 'Broad', 'AG012'),
('K013', 'fitness equipment', 'Phrase', 'AG013'),
('K014', 'cyber monday discounts', 'Exact', 'AG014'),
('K015', 'car accessories sale', 'Broad', 'AG015'),
('K016', 'pet supplies', 'Phrase', 'AG016'),
('K017', 'travel deals 2024', 'Exact', 'AG017'),
('K018', 'summer fashion', 'Broad', 'AG018'),
('K019', 'kids clothing offers', 'Phrase', 'AG019'),
('K020', 'electric vehicles', 'Exact', 'AG020'),
('K021', 'smart home gadgets', 'Broad', 'AG021'),
('K022', 'wedding accessories', 'Phrase', 'AG022'),
('K023', 'online learning courses', 'Exact', 'AG023'),
('K024', 'back to school deals', 'Broad', 'AG024'),
('K025', 'health insurance plans', 'Phrase', 'AG025'),
('K026', 'holiday travel packages', 'Exact', 'AG026'),
('K027', 'work from home essentials', 'Broad', 'AG027'),
('K028', 'tech startup funding', 'Phrase', 'AG028'),
('K029', 'best tablets under 500', 'Exact', 'AG029'),
('K030', 'investment strategies', 'Broad', 'AG030'),
('K031', 'high yield savings accounts', 'Phrase', 'AG031'),
('K032', 'best credit card rewards', 'Exact', 'AG032'),
('K033', 'solar energy solutions', 'Broad', 'AG033'),
('K034', 'kitchen appliance deals', 'Phrase', 'AG034'),
('K035', 'top-rated headphones', 'Exact', 'AG035'),
('K036', 'home security systems', 'Broad', 'AG036'),
('K037', 'gardening supplies', 'Phrase', 'AG037'),
('K038', 'smart fitness trackers', 'Exact', 'AG038'),
('K039', 'furniture clearance sale', 'Broad', 'AG039'),
('K040', 'best VPN services', 'Phrase', 'AG040'),
('K041', 'cloud storage providers', 'Exact', 'AG041'),
('K042', 'professional photography gear', 'Broad', 'AG042'),
('K043', 'office furniture discounts', 'Phrase', 'AG043'),
('K044', 'luxury handbags sale', 'Exact', 'AG044'),
('K045', 'fine jewelry discounts', 'Broad', 'AG045'),
('K046', 'student laptop offers', 'Phrase', 'AG046'),
('K047', 'outdoor adventure gear', 'Exact', 'AG047'),
('K048', 'art supplies for sale', 'Broad', 'AG048'),
('K049', 'electric bike deals', 'Phrase', 'AG049'),
('K050', 'home workout routines', 'Exact', 'AG050');


-- Audience Table
INSERT INTO Audience VALUES
('AU001', 'Young Shoppers', 'Ages 18-25, interested in fashion'),
('AU002', 'Tech Enthusiasts', 'Frequent buyers of electronics'),
('AU003', 'Parents', 'Looking for school-related products'),
('AU004', 'Deal Hunters', 'Responds well to heavy discounts'),
('AU005', 'Luxury Shoppers', 'High-income individuals seeking premium products'),
('AU006', 'Frequent Travelers', 'People who travel often for work or leisure'),
('AU007', 'Health Conscious', 'Individuals focused on fitness and wellness'),
('AU008', 'Home Decor Lovers', 'Interested in interior design and home improvement'),
('AU009', 'Pet Owners', 'People who own pets and buy pet-related products'),
('AU010', 'Gaming Enthusiasts', 'Regular buyers of video games and accessories'),
('AU011', 'Book Readers', 'People interested in purchasing books and ebooks'),
('AU012', 'Outdoor Adventurers', 'People who enjoy hiking, camping, and outdoor activities'),
('AU013', 'College Students', 'Young adults pursuing higher education'),
('AU014', 'Business Professionals', 'Working professionals interested in career growth'),
('AU015', 'Home Cooks', 'People interested in cooking and kitchen gadgets'),
('AU016', 'Fashion Trendsetters', 'Those who closely follow fashion trends'),
('AU017', 'DIY Enthusiasts', 'People who enjoy DIY projects and crafts'),
('AU018', 'Eco-Friendly Consumers', 'Consumers interested in sustainable and green products'),
('AU019', 'Parents of Toddlers', 'Parents with young children, ages 1-4'),
('AU020', 'Sports Fans', 'People who actively follow and watch sports'),
('AU021', 'Luxury Car Buyers', 'Individuals interested in high-end automobiles'),
('AU022', 'Budget Shoppers', 'Consumers who actively seek deals and discounts'),
('AU023', 'Tech Geeks', 'Early adopters of the latest technology'),
('AU024', 'Freelancers', 'Self-employed professionals looking for work solutions'),
('AU025', 'Music Lovers', 'People who frequently buy or stream music'),
('AU026', 'Coffee Enthusiasts', 'Consumers who are passionate about coffee brewing'),
('AU027', 'Fitness Freaks', 'People who regularly engage in fitness activities'),
('AU028', 'Online Gamers', 'Individuals who actively play online multiplayer games'),
('AU029', 'New Homeowners', 'People who have recently purchased a home'),
('AU030', 'Senior Citizens', 'Older adults looking for lifestyle and healthcare products'),
('AU031', 'Vegan Consumers', 'People who follow a vegan diet and lifestyle'),
('AU032', 'Adventure Travelers', 'People interested in adventure tourism and experiences'),
('AU033', 'Investment Seekers', 'Individuals looking for investment opportunities'),
('AU034', 'Photography Enthusiasts', 'Hobbyists and professionals interested in cameras and accessories'),
('AU035', 'Remote Workers', 'People working from home or in hybrid work settings'),
('AU036', 'Streaming Addicts', 'Consumers who frequently watch streaming services'),
('AU037', 'Parents of Teens', 'Parents with teenage children, ages 13-19'),
('AU038', 'Foodies', 'People who enjoy exploring new cuisines and dining experiences'),
('AU039', 'Sustainable Living Advocates', 'Individuals focused on reducing environmental impact'),
('AU040', 'Frequent Shoppers', 'People who shop online or in-store frequently'),
('AU041', 'Small Business Owners', 'Entrepreneurs managing small-scale businesses'),
('AU042', 'Art Collectors', 'People who purchase fine art and collectibles'),
('AU043', 'DIY Home Renovators', 'Individuals interested in home renovation projects'),
('AU044', 'Luxury Travelers', 'High-income individuals who travel in luxury'),
('AU045', 'Collectors', 'People who collect rare and unique items'),
('AU046', 'Car Enthusiasts', 'People who follow automobile trends and modifications'),
('AU047', 'Sustainable Fashion Buyers', 'Consumers who purchase ethical and sustainable clothing'),
('AU048', 'Young Parents', 'Parents with infants and young children'),
('AU049', 'Tech Investors', 'Individuals investing in technology startups and stocks'),
('AU050', 'Gaming Streamers', 'Content creators who stream gaming sessions online');


-- Ad Placement Table
INSERT INTO AdPlacement VALUES
('AP001', 'Search', 'Google Search', 'A001'),
('AP002', 'Display', 'YouTube', 'A002'),
('AP003', 'Video', 'Facebook Ads', 'A003'),
('AP004', 'Search', 'Bing Search', 'A004'),
('AP005', 'Display', 'Instagram Ads', 'A005'),
('AP006', 'Video', 'TikTok Ads', 'A006'),
('AP007', 'Search', 'Yahoo Search', 'A007'),
('AP008', 'Display', 'Reddit Ads', 'A008'),
('AP009', 'Video', 'Snapchat Ads', 'A009'),
('AP010', 'Search', 'Google Search', 'A010'),
('AP011', 'Display', 'YouTube', 'A011'),
('AP012', 'Video', 'Facebook Ads', 'A012'),
('AP013', 'Search', 'Bing Search', 'A013'),
('AP014', 'Display', 'Instagram Ads', 'A014'),
('AP015', 'Video', 'TikTok Ads', 'A015'),
('AP016', 'Search', 'Yahoo Search', 'A016'),
('AP017', 'Display', 'Reddit Ads', 'A017'),
('AP018', 'Video', 'Snapchat Ads', 'A018'),
('AP019', 'Search', 'Google Search', 'A019'),
('AP020', 'Display', 'YouTube', 'A020'),
('AP021', 'Video', 'Facebook Ads', 'A021'),
('AP022', 'Search', 'Bing Search', 'A022'),
('AP023', 'Display', 'Instagram Ads', 'A023'),
('AP024', 'Video', 'TikTok Ads', 'A024'),
('AP025', 'Search', 'Yahoo Search', 'A025'),
('AP026', 'Display', 'Reddit Ads', 'A026'),
('AP027', 'Video', 'Snapchat Ads', 'A027'),
('AP028', 'Search', 'Google Search', 'A028'),
('AP029', 'Display', 'YouTube', 'A029'),
('AP030', 'Video', 'Facebook Ads', 'A030'),
('AP031', 'Search', 'Bing Search', 'A031'),
('AP032', 'Display', 'Instagram Ads', 'A032'),
('AP033', 'Video', 'TikTok Ads', 'A033'),
('AP034', 'Search', 'Yahoo Search', 'A034'),
('AP035', 'Display', 'Reddit Ads', 'A035'),
('AP036', 'Video', 'Snapchat Ads', 'A036'),
('AP037', 'Search', 'Google Search', 'A037'),
('AP038', 'Display', 'YouTube', 'A038'),
('AP039', 'Video', 'Facebook Ads', 'A039'),
('AP040', 'Search', 'Bing Search', 'A040'),
('AP041', 'Display', 'Instagram Ads', 'A041'),
('AP042', 'Video', 'TikTok Ads', 'A042'),
('AP043', 'Search', 'Yahoo Search', 'A043'),
('AP044', 'Display', 'Reddit Ads', 'A044'),
('AP045', 'Video', 'Snapchat Ads', 'A045'),
('AP046', 'Search', 'Google Search', 'A046'),
('AP047', 'Display', 'YouTube', 'A047'),
('AP048', 'Video', 'Facebook Ads', 'A048'),
('AP049', 'Search', 'Bing Search', 'A049'),
('AP050', 'Display', 'Instagram Ads', 'A050');

-- Performance Metrics Table
INSERT INTO PerformanceMetrics VALUES
('PM001', 10000, 500, 50, 0.50, 'A001'),
('PM002', 15000, 750, 80, 0.40, 'A002'),
('PM003', 20000, 1200, 150, 0.35, 'A003'),
('PM004', 12000, 600, 70, 0.45, 'A004'),
('PM005', 8000, 300, 40, 0.55, 'A005'),
('PM006', 9500, 450, 45, 0.52, 'A006'),
('PM007', 17000, 900, 100, 0.38, 'A007'),
('PM008', 11000, 550, 60, 0.48, 'A008'),
('PM009', 22000, 1300, 160, 0.33, 'A009'),
('PM010', 13000, 650, 75, 0.43, 'A010'),
('PM011', 14000, 700, 85, 0.42, 'A011'),
('PM012', 21000, 1250, 155, 0.34, 'A012'),
('PM013', 9000, 400, 42, 0.53, 'A013'),
('PM014', 16000, 850, 90, 0.39, 'A014'),
('PM015', 12000, 600, 72, 0.46, 'A015'),
('PM016', 19500, 1000, 140, 0.36, 'A016'),
('PM017', 11500, 580, 65, 0.47, 'A017'),
('PM018', 8500, 350, 38, 0.54, 'A018'),
('PM019', 18000, 950, 110, 0.37, 'A019'),
('PM020', 17500, 920, 105, 0.37, 'A020'),
('PM021', 20000, 1100, 135, 0.35, 'A021'),
('PM022', 12500, 620, 78, 0.44, 'A022'),
('PM023', 19000, 970, 120, 0.36, 'A023'),
('PM024', 15500, 810, 95, 0.40, 'A024'),
('PM025', 10500, 530, 62, 0.49, 'A025'),
('PM026', 9800, 490, 55, 0.51, 'A026'),
('PM027', 20500, 1150, 145, 0.34, 'A027'),
('PM028', 13500, 670, 82, 0.42, 'A028'),
('PM029', 14200, 720, 88, 0.41, 'A029'),
('PM030', 12700, 640, 77, 0.44, 'A030'),
('PM031', 16500, 860, 98, 0.39, 'A031'),
('PM032', 10800, 540, 63, 0.48, 'A032'),
('PM033', 14800, 750, 92, 0.40, 'A033'),
('PM034', 21000, 1180, 150, 0.34, 'A034'),
('PM035', 9000, 420, 46, 0.52, 'A035'),
('PM036', 18700, 940, 115, 0.37, 'A036'),
('PM037', 11900, 590, 70, 0.46, 'A037'),
('PM038', 14000, 730, 89, 0.41, 'A038'),
('PM039', 15500, 800, 93, 0.40, 'A039'),
('PM040', 11200, 560, 67, 0.47, 'A040'),
('PM041', 16800, 870, 102, 0.38, 'A041'),
('PM042', 9700, 480, 54, 0.51, 'A042'),
('PM043', 20700, 1160, 148, 0.34, 'A043'),
('PM044', 12800, 650, 79, 0.44, 'A044'),
('PM045', 13500, 700, 86, 0.42, 'A045'),
('PM046', 12300, 630, 75, 0.45, 'A046'),
('PM047', 16000, 830, 97, 0.39, 'A047'),
('PM048', 11000, 550, 64, 0.48, 'A048'),
('PM049', 14500, 760, 91, 0.40, 'A049'),
('PM050', 21200, 1200, 155, 0.34, 'A050');


-- Budget Allocation Table
INSERT INTO BudgetAllocation VALUES
('BA001', 5000.00, 3000.00, 'C001'),
('BA002', 7000.00, 5000.00, 'C002'),
('BA003', 4500.00, 2000.00, 'C003'),
('BA004', 8000.00, 6000.00, 'C004'),
('BA005', 12000.00, 10000.00, 'C005'),
('BA006', 5300.00, 3100.00, 'C006'),
('BA007', 7200.00, 5100.00, 'C007'),
('BA008', 4600.00, 2100.00, 'C008'),
('BA009', 8100.00, 6200.00, 'C009'),
('BA010', 12500.00, 10200.00, 'C010'),
('BA011', 4900.00, 2900.00, 'C011'),
('BA012', 6800.00, 4800.00, 'C012'),
('BA013', 4400.00, 1900.00, 'C013'),
('BA014', 7900.00, 5800.00, 'C014'),
('BA015', 11800.00, 9800.00, 'C015'),
('BA016', 5100.00, 3000.00, 'C016'),
('BA017', 7100.00, 4900.00, 'C017'),
('BA018', 4700.00, 2200.00, 'C018'),
('BA019', 8300.00, 6400.00, 'C019'),
('BA020', 12600.00, 10400.00, 'C020'),
('BA021', 5000.00, 2800.00, 'C021'),
('BA022', 6750.00, 4600.00, 'C022'),
('BA023', 4300.00, 1850.00, 'C023'),
('BA024', 7700.00, 5600.00, 'C024'),
('BA025', 11700.00, 9600.00, 'C025'),
('BA026', 5400.00, 3200.00, 'C026'),
('BA027', 7400.00, 5200.00, 'C027'),
('BA028', 4800.00, 2300.00, 'C028'),
('BA029', 8500.00, 6600.00, 'C029'),
('BA030', 12800.00, 10600.00, 'C030'),
('BA031', 5200.00, 3100.00, 'C031'),
('BA032', 7300.00, 5000.00, 'C032'),
('BA033', 4600.00, 2150.00, 'C033'),
('BA034', 8000.00, 6000.00, 'C034'),
('BA035', 12100.00, 9900.00, 'C035'),
('BA036', 5300.00, 3150.00, 'C036'),
('BA037', 7500.00, 5300.00, 'C037'),
('BA038', 4700.00, 2250.00, 'C038'),
('BA039', 8700.00, 6800.00, 'C039'),
('BA040', 13000.00, 10800.00, 'C040'),
('BA041', 5600.00, 3300.00, 'C041'),
('BA042', 7700.00, 5500.00, 'C042'),
('BA043', 4900.00, 2400.00, 'C043'),
('BA044', 8800.00, 6900.00, 'C044'),
('BA045', 13300.00, 11100.00, 'C045'),
('BA046', 5700.00, 3400.00, 'C046'),
('BA047', 7900.00, 5700.00, 'C047'),
('BA048', 5000.00, 2500.00, 'C048'),
('BA049', 8900.00, 7000.00, 'C049'),
('BA050', 13500.00, 11300.00, 'C050');


-- Junction Tables
-- AdGroupKeyword Table 
INSERT INTO AdGroupKeyword VALUES
('AG001', 'K001'),
('AG001', 'K002'),
('AG003', 'K003'),
('AG004', 'K004'),
('AG005', 'K005'),
('AG001', 'K006'),
('AG002', 'K007'),
('AG003', 'K008'),
('AG004', 'K009'),
('AG005', 'K010'),
('AG001', 'K011'),
('AG002', 'K012'),
('AG003', 'K013'),
('AG004', 'K014'),
('AG005', 'K015'),
('AG001', 'K016'),
('AG002', 'K017'),
('AG003', 'K018'),
('AG004', 'K019'),
('AG005', 'K020'),
('AG001', 'K021'),
('AG002', 'K022'),
('AG003', 'K023'),
('AG004', 'K024'),
('AG005', 'K025'),
('AG001', 'K026'),
('AG002', 'K027'),
('AG003', 'K028'),
('AG004', 'K029'),
('AG005', 'K030'),
('AG001', 'K031'),
('AG002', 'K032'),
('AG003', 'K033'),
('AG004', 'K034'),
('AG005', 'K035'),
('AG001', 'K036'),
('AG002', 'K037'),
('AG003', 'K038'),
('AG004', 'K039'),
('AG005', 'K040'),
('AG001', 'K041'),
('AG002', 'K042'),
('AG003', 'K043'),
('AG004', 'K044'),
('AG005', 'K045'),
('AG001', 'K046'),
('AG002', 'K047'),
('AG003', 'K048'),
('AG004', 'K049'),
('AG005', 'K050');

-- CampaignAudience Table 
INSERT INTO CampaignAudience VALUES
('C001', 'AU001'),
('C002', 'AU002'),
('C003', 'AU003'),
('C004', 'AU004'),
('C005', 'AU005'),
('C001', 'AU006'),
('C002', 'AU007'),
('C003', 'AU008'),
('C004', 'AU009'),
('C005', 'AU010'),
('C001', 'AU011'),
('C002', 'AU012'),
('C003', 'AU013'),
('C004', 'AU014'),
('C005', 'AU015'),
('C001', 'AU016'),
('C002', 'AU017'),
('C003', 'AU018'),
('C004', 'AU019'),
('C005', 'AU020'),
('C001', 'AU021'),
('C002', 'AU022'),
('C003', 'AU023'),
('C004', 'AU024'),
('C005', 'AU025'),
('C001', 'AU026'),
('C002', 'AU027'),
('C003', 'AU028'),
('C004', 'AU029'),
('C005', 'AU030'),
('C001', 'AU031'),
('C002', 'AU032'),
('C003', 'AU033'),
('C004', 'AU034'),
('C005', 'AU035'),
('C001', 'AU036'),
('C002', 'AU037'),
('C003', 'AU038'),
('C004', 'AU039'),
('C005', 'AU040'),
('C001', 'AU041'),
('C002', 'AU042'),
('C003', 'AU043'),
('C004', 'AU044'),
('C005', 'AU045'),
('C001', 'AU046'),
('C002', 'AU047'),
('C003', 'AU048'),
('C004', 'AU049'),
('C005', 'AU050');

-- AdPlacementTracking Table
INSERT INTO AdPlacementTracking VALUES
('A001', 'AP001'),
('A002', 'AP002'),
('A003', 'AP003'),
('A004', 'AP004'),
('A005', 'AP005'),
('A006', 'AP006'),
('A007', 'AP007'),
('A008', 'AP008'),
('A009', 'AP009'),
('A010', 'AP010'),
('A011', 'AP011'),
('A012', 'AP012'),
('A013', 'AP013'),
('A014', 'AP014'),
('A015', 'AP015'),
('A016', 'AP016'),
('A017', 'AP017'),
('A018', 'AP018'),
('A019', 'AP019'),
('A020', 'AP020'),
('A021', 'AP021'),
('A022', 'AP022'),
('A023', 'AP023'),
('A024', 'AP024'),
('A025', 'AP025'),
('A026', 'AP026'),
('A027', 'AP027'),
('A028', 'AP028'),
('A029', 'AP029'),
('A030', 'AP030'),
('A031', 'AP031'),
('A032', 'AP032'),
('A033', 'AP033'),
('A034', 'AP034'),
('A035', 'AP035'),
('A036', 'AP036'),
('A037', 'AP037'),
('A038', 'AP038'),
('A039', 'AP039'),
('A040', 'AP040'),
('A041', 'AP041'),
('A042', 'AP042'),
('A043', 'AP043'),
('A044', 'AP044'),
('A045', 'AP045'),
('A046', 'AP046'),
('A047', 'AP047'),
('A048', 'AP048'),
('A049', 'AP049'),
('A050', 'AP050');


-- View Campaign Table
SELECT * FROM Campaign;

-- View AdGroup Table
SELECT * FROM AdGroup;

-- View Ad Table
SELECT * FROM Ad;

-- View Keyword Table
SELECT * FROM Keyword;

-- View Audience Table
SELECT * FROM Audience;

-- View Ad Placement Table
SELECT * FROM AdPlacement;

-- View Performance Metrics Table
SELECT * FROM PerformanceMetrics;

-- View Budget Allocation Table
SELECT * FROM BudgetAllocation;

-- View AdGroupKeyword Junction Table
SELECT * FROM AdGroupKeyword;

-- View CampaignAudience Junction Table
SELECT * FROM CampaignAudience;

-- View AdPlacementTracking Junction Table
SELECT * FROM AdPlacementTracking;
SHOW tables;

-- nummber of tables in database
SELECT COUNT(*) 
FROM information_schema.tables 
WHERE table_schema = 'sg47_AdCampaignDB';

USE sg47_AdCampaignDB;

-- STRESS TESTING (Notice : All tables here are not in normal form)
-- 1. Inserting Large Volumes of Data
INSERT INTO AdGroupKeyword (AdGroupId, KeywordId)
SELECT DISTINCT AdGroupId, KeywordId
FROM (
    SELECT 
        (SELECT AdGroupId FROM AdGroup ORDER BY RAND() LIMIT 1) AS AdGroupId,
        (SELECT KeywordId FROM Keyword ORDER BY RAND() LIMIT 1) AS KeywordId
    FROM information_schema.tables
    LIMIT 100000
) AS temp
WHERE NOT EXISTS (
    SELECT 1 FROM AdGroupKeyword
    WHERE AdGroupKeyword.AdGroupId = temp.AdGroupId 
      AND AdGroupKeyword.KeywordId = temp.KeywordId
);

Select * from AdGroupKeyword;


-- 2. Running Concurrent Queries
SELECT BENCHMARK(1000000, (SELECT COUNT(*) FROM AdGroupKeyword));


-- 3. Measuring Query Performance
-- Query execution time : 
EXPLAIN ANALYZE 
SELECT * FROM AdGroupKeyword WHERE AdGroupId = 'AG500';

-- Enable query profiling : 
SET profiling = 1;
SELECT * FROM AdGroupKeyword WHERE KeywordId = 'K500';
SHOW PROFILES;


-- 4. Simulating transactions under load 
START TRANSACTION;
UPDATE BudgetAllocation SET SpentAmount = SpentAmount + 100 WHERE CampaignId = 'C001';
SELECT * FROM BudgetAllocation WHERE CampaignId = 'C001' FOR UPDATE;
COMMIT;


-- 5. Checking system performance (CPU, RAM, Disk Usage)
SELECT * FROM performance_schema.events_statements_summary_by_digest ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;


-- 6. Optimizing based ion results
CREATE INDEX idx_adgroup_keyword ON AdGroupKeyword1(ad_group_id, keyword_id);

-- --------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating the tables again with 1NF and 2NF normalization and then will drop the tables created above

-- Normalized Campaign Table
CREATE TABLE Campaign1 (
    campaign_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    status ENUM('Active', 'Inactive', 'Upcoming') NOT NULL
);

-- Normalized Ad Group Table
CREATE TABLE AdGroup1 (
    ad_group_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    strategy VARCHAR(255) NOT NULL,
    campaign_id VARCHAR(10),
    FOREIGN KEY (campaign_id) REFERENCES Campaign1(campaign_id)
);

-- Normalized Ad Table
CREATE TABLE Ad1 (
    ad_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type ENUM('Text', 'Image', 'Video') NOT NULL,
    description TEXT NOT NULL,
    url VARCHAR(255) NOT NULL,
    campaign_id VARCHAR(10),
    FOREIGN KEY (campaign_id) REFERENCES Campaign1(campaign_id)
);

-- Normalized Keyword Table
CREATE TABLE Keyword1 (
    keyword_id VARCHAR(10) PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    match_type ENUM('Broad', 'Phrase', 'Exact') NOT NULL
);

-- Bridge Table for AdGroup and Keywords (to remove multi-values in 1NF)
CREATE TABLE AdGroupKeyword1 (
    ad_group_id VARCHAR(10),
    keyword_id VARCHAR(10),
    PRIMARY KEY (ad_group_id, keyword_id),
    FOREIGN KEY (ad_group_id) REFERENCES AdGroup1(ad_group_id),
    FOREIGN KEY (keyword_id) REFERENCES Keyword1(keyword_id)
);

-- Normalized Audience Table
CREATE TABLE Audience1 (
    audience_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);

-- Bridge Table for Campaign and Audience (removing multi-values for 1NF)
CREATE TABLE CampaignAudience1 (
    campaign_id VARCHAR(10),
    audience_id VARCHAR(10),
    PRIMARY KEY (campaign_id, audience_id),
    FOREIGN KEY (campaign_id) REFERENCES Campaign1(campaign_id),
    FOREIGN KEY (audience_id) REFERENCES Audience1(audience_id)
);

-- Normalized Ad Placement Table
CREATE TABLE AdPlacement1 (
    ad_placement_id VARCHAR(10) PRIMARY KEY,
    type ENUM('Search', 'Display', 'Video') NOT NULL,
    platform VARCHAR(255) NOT NULL
);

-- Bridge Table for Ad and Ad Placement
CREATE TABLE AdPlacementTracking1 (
    ad_id VARCHAR(10),
    ad_placement_id VARCHAR(10),
    PRIMARY KEY (ad_id, ad_placement_id),
    FOREIGN KEY (ad_id) REFERENCES Ad1(ad_id),
    FOREIGN KEY (ad_placement_id) REFERENCES AdPlacement1(ad_placement_id)
);

-- Normalized Performance Metrics Table
CREATE TABLE PerformanceMetrics1 (
    performance_id VARCHAR(10) PRIMARY KEY,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL,
    ctr DECIMAL(5,2) NOT NULL,
    ad_id VARCHAR(10),
    FOREIGN KEY (ad_id) REFERENCES Ad1(ad_id)
);

-- Normalized Budget Allocation Table
CREATE TABLE BudgetAllocation1 (
    budget_id VARCHAR(10) PRIMARY KEY,
    total_budget DECIMAL(10,2) NOT NULL,
    spent_budget DECIMAL(10,2) NOT NULL,
    campaign_id VARCHAR(10),
    FOREIGN KEY (campaign_id) REFERENCES Campaign1(campaign_id)
);




-- Campaign Table
INSERT INTO Campaign1 VALUES
('C001', 'Spring Sale', '2024-01-01', '2024-03-31', 5000.00, 'Active'),
('C002', 'Winter Clearance', '2024-02-01', '2024-04-30', 7000.00, 'Active'),
('C003', 'Tech Deals', '2024-01-15', '2024-03-15', 4500.00, 'Inactive'),
('C004', 'Back to School', '2024-06-01', '2024-08-31', 8000.00, 'Active'),
('C005', 'Black Friday Special', '2024-11-01', '2024-11-30', 12000.00, 'Upcoming'),
('C006', 'Summer Bonanza', '2024-05-01', '2024-07-31', 6000.00, 'Active'),
('C007', 'Cyber Monday', '2024-11-25', '2024-11-30', 10000.00, 'Upcoming'),
('C008', 'New Year Celebration', '2024-12-15', '2025-01-15', 9000.00, 'Upcoming'),
('C009', 'Fashion Week Sale', '2024-09-01', '2024-09-30', 7500.00, 'Active'),
('C010', 'Gadget Festival', '2024-10-01', '2024-10-31', 8500.00, 'Active'),
('C011', 'Automotive Discounts', '2024-03-01', '2024-05-31', 6200.00, 'Active'),
('C012', 'Home Essentials Sale', '2024-06-15', '2024-08-15', 7800.00, 'Active'),
('C013', 'Fitness Frenzy', '2024-04-01', '2024-06-30', 7200.00, 'Inactive'),
('C014', 'Beauty Bonanza', '2024-07-01', '2024-09-30', 6700.00, 'Active'),
('C015', 'Gaming Discounts', '2024-08-01', '2024-08-31', 5000.00, 'Active'),
('C016', 'Health & Wellness', '2024-03-01', '2024-06-01', 6500.00, 'Inactive'),
('C017', 'Valentine’s Day Special', '2024-02-01', '2024-02-14', 4500.00, 'Active'),
('C018', 'Pet Supplies Sale', '2024-05-01', '2024-07-31', 7100.00, 'Active'),
('C019', 'Office Essentials Sale', '2024-09-01', '2024-10-31', 7300.00, 'Active'),
('C020', 'Music Lovers Campaign', '2024-06-01', '2024-07-31', 6200.00, 'Active'),
('C021', 'Luxury Brands Fest', '2024-11-01', '2024-12-31', 15000.00, 'Upcoming'),
('C022', 'Eco-Friendly Products', '2024-07-01', '2024-09-30', 6800.00, 'Active'),
('C023', 'Baby Products Sale', '2024-04-01', '2024-06-30', 7000.00, 'Active'),
('C024', 'B2B Promotions', '2024-03-01', '2024-05-31', 9000.00, 'Active'),
('C025', 'Freelancer Tools Discount', '2024-06-15', '2024-08-15', 8000.00, 'Inactive'),
('C026', 'Wedding Season Sale', '2024-09-01', '2024-10-15', 7500.00, 'Active'),
('C027', 'End of Season Sale', '2024-12-01', '2024-12-31', 9200.00, 'Upcoming'),
('C028', 'AI & Tech Innovations', '2024-10-01', '2024-11-30', 9500.00, 'Active'),
('C029', 'Small Business Growth', '2024-02-01', '2024-04-30', 8500.00, 'Active'),
('C030', 'Influencer Deals', '2024-07-01', '2024-08-31', 7200.00, 'Active'),
('C031', 'Student Discounts', '2024-05-01', '2024-06-30', 5800.00, 'Active'),
('C032', 'Sports Fan Campaign', '2024-08-01', '2024-09-30', 6300.00, 'Active'),
('C033', 'Backyard Makeover', '2024-03-01', '2024-05-15', 7100.00, 'Active'),
('C034', 'Sustainable Living Sale', '2024-09-01', '2024-11-01', 8200.00, 'Active'),
('C035', 'Frequent Flyer Discounts', '2024-06-01', '2024-08-01', 9700.00, 'Active'),
('C036', 'Exclusive VIP Offers', '2024-11-01', '2024-12-31', 14000.00, 'Upcoming'),
('C037', 'Mother’s Day Specials', '2024-04-15', '2024-05-15', 6000.00, 'Active'),
('C038', 'Father’s Day Deals', '2024-05-15', '2024-06-15', 6300.00, 'Active'),
('C039', 'Eco-Conscious Fashion', '2024-07-01', '2024-09-01', 7500.00, 'Active'),
('C040', 'Freelancer Deals', '2024-08-01', '2024-09-15', 6900.00, 'Active'),
('C041', 'Laptop Discounts', '2024-03-01', '2024-05-01', 8800.00, 'Active'),
('C042', 'Educational Resources', '2024-02-01', '2024-03-31', 5800.00, 'Active'),
('C043', 'Remote Work Essentials', '2024-04-01', '2024-06-01', 7700.00, 'Active'),
('C044', 'Streaming Services Sale', '2024-06-01', '2024-07-31', 8100.00, 'Active'),
('C045', 'Organic Food Specials', '2024-09-01', '2024-10-31', 8600.00, 'Active'),
('C046', 'Smart Home Upgrades', '2024-10-01', '2024-12-01', 9400.00, 'Active'),
('C047', 'E-Sports Promotions', '2024-07-01', '2024-08-31', 7000.00, 'Active'),
('C048', 'Auto Parts Discounts', '2024-05-01', '2024-07-01', 7500.00, 'Active'),
('C049', 'Winter Accessories', '2024-11-01', '2024-12-31', 9900.00, 'Upcoming'),
('C050', 'Year-End Clearance', '2024-12-15', '2025-01-15', 10500.00, 'Upcoming');


-- Ad Group Table
INSERT INTO AdGroup1 VALUES
('AG001', 'High Bid Strategy', 'Maximize Clicks', 'C001'),
('AG002', 'Budget Friendly Ads', 'Target CPA', 'C002'),
('AG003', 'Premium Product Ads', 'ROAS Optimization', 'C003'),
('AG004', 'Seasonal Offers', 'Enhanced CPC', 'C004'),
('AG005', 'Discount Focused', 'Manual CPC', 'C005'),
('AG006', 'Fashion Deals', 'Maximize Conversions', 'C006'),
('AG007', 'Tech Enthusiasts', 'ROAS Optimization', 'C007'),
('AG008', 'Automotive Promotions', 'Enhanced CPC', 'C008'),
('AG009', 'Travel Campaigns', 'Target CPA', 'C009'),
('AG010', 'E-commerce Growth', 'Maximize Clicks', 'C010'),
('AG011', 'Health & Wellness', 'Maximize Conversions', 'C011'),
('AG012', 'Fitness Enthusiasts', 'Target ROAS', 'C012'),
('AG013', 'Home Improvement', 'Enhanced CPC', 'C013'),
('AG014', 'Luxury Fashion', 'Manual CPC', 'C014'),
('AG015', 'Electronics Discounts', 'Target CPA', 'C015'),
('AG016', 'Pet Supplies', 'Maximize Clicks', 'C016'),
('AG017', 'Gaming Accessories', 'ROAS Optimization', 'C017'),
('AG018', 'Food & Beverages', 'Target CPA', 'C018'),
('AG019', 'B2B Marketing', 'Enhanced CPC', 'C019'),
('AG020', 'Home Decor', 'Maximize Conversions', 'C020'),
('AG021', 'Kids Fashion', 'Manual CPC', 'C021'),
('AG022', 'Music Equipment', 'Maximize Clicks', 'C022'),
('AG023', 'Smart Gadgets', 'ROAS Optimization', 'C023'),
('AG024', 'Outdoor Adventures', 'Target CPA', 'C024'),
('AG025', 'Beauty & Skincare', 'Enhanced CPC', 'C025'),
('AG026', 'Automotive Accessories', 'Maximize Clicks', 'C026'),
('AG027', 'Mobile Accessories', 'Target ROAS', 'C027'),
('AG028', 'Streaming Services', 'Manual CPC', 'C028'),
('AG029', 'Education & Learning', 'Maximize Conversions', 'C029'),
('AG030', 'Subscription Boxes', 'Enhanced CPC', 'C030'),
('AG031', 'Handmade Crafts', 'Target CPA', 'C031'),
('AG032', 'Wedding Services', 'ROAS Optimization', 'C032'),
('AG033', 'Freelance Services', 'Manual CPC', 'C033'),
('AG034', 'Real Estate Promotions', 'Maximize Clicks', 'C034'),
('AG035', 'Luxury Travel', 'Target ROAS', 'C035'),
('AG036', 'Grocery Discounts', 'Enhanced CPC', 'C036'),
('AG037', 'Personal Finance', 'Target CPA', 'C037'),
('AG038', 'Green Energy Solutions', 'ROAS Optimization', 'C038'),
('AG039', 'Cybersecurity Products', 'Maximize Conversions', 'C039'),
('AG040', 'Insurance Offers', 'Target CPA', 'C040'),
('AG041', 'DIY & Crafting', 'Manual CPC', 'C041'),
('AG042', 'Local Businesses', 'Enhanced CPC', 'C042'),
('AG043', 'Job Listings', 'Maximize Clicks', 'C043'),
('AG044', 'Fitness Programs', 'Target ROAS', 'C044'),
('AG045', 'Charity & Nonprofits', 'ROAS Optimization', 'C045'),
('AG046', 'Event Promotions', 'Target CPA', 'C046'),
('AG047', 'Luxury Cars', 'Maximize Conversions', 'C047'),
('AG048', 'AI & Tech Innovations', 'Enhanced CPC', 'C048'),
('AG049', 'Holiday Specials', 'Manual CPC', 'C049'),
('AG050', 'Business Software', 'Target ROAS', 'C050');

-- Ad Table
INSERT INTO Ad1 VALUES
('A001', 'Spring Ad 1', 'Text', 'Best Spring Deals!', 'https://example.com/spring', 'C001'),
('A002', 'Spring Ad 2', 'Image', 'Amazing Discounts!', 'https://example.com/spring', 'C001'),
('A003', 'Winter Sale', 'Video', 'Biggest Winter Sale!', 'https://example.com/winter', 'C002'),
('A004', 'Tech Ad', 'Text', 'Latest Gadgets Here!', 'https://example.com/tech', 'C003'),
('A005', 'School Essentials', 'Image', 'Back-to-School Savings!', 'https://example.com/school', 'C004'),
('A006', 'Summer Collection', 'Image', 'New Summer Arrivals!', 'https://example.com/summer', 'C006'),
('A007', 'Gaming Gear Sale', 'Video', 'Top Gaming Accessories!', 'https://example.com/gaming', 'C007'),
('A008', 'Car Accessories', 'Text', 'Upgrade Your Ride!', 'https://example.com/auto', 'C008'),
('A009', 'Flight Deals', 'Image', 'Discounted Flights!', 'https://example.com/travel', 'C009'),
('A010', 'Online Shopping Festival', 'Video', 'Mega Sale Event!', 'https://example.com/ecommerce', 'C010'),
('A011', 'Fitness Ad', 'Text', 'Stay Fit with Top Gear!', 'https://example.com/fitness', 'C011'),
('A012', 'Luxury Watches', 'Image', 'Timeless Elegance!', 'https://example.com/watches', 'C012'),
('A013', 'Pet Supplies', 'Video', 'Everything for Your Pet!', 'https://example.com/pets', 'C013'),
('A014', 'Beauty Products', 'Text', 'Glow Like Never Before!', 'https://example.com/beauty', 'C014'),
('A015', 'Home Decor', 'Image', 'Stylish Interiors Await!', 'https://example.com/home', 'C015'),
('A016', 'Smartphones Sale', 'Text', 'Latest Phones at Best Prices!', 'https://example.com/mobiles', 'C016'),
('A017', 'Wedding Specials', 'Image', 'Make Your Day Memorable!', 'https://example.com/wedding', 'C017'),
('A018', 'Movie Subscriptions', 'Video', 'Unlimited Entertainment!', 'https://example.com/movies', 'C018'),
('A019', 'Healthy Eating', 'Text', 'Fresh Organic Choices!', 'https://example.com/organic', 'C019'),
('A020', 'Outdoor Camping', 'Image', 'Gear Up for Adventure!', 'https://example.com/camping', 'C020'),
('A021', 'Automobile Ad', 'Video', 'Experience the Thrill!', 'https://example.com/cars', 'C021'),
('A022', 'Book Sale', 'Text', 'Bestsellers at Huge Discounts!', 'https://example.com/books', 'C022'),
('A023', 'Educational Courses', 'Image', 'Upgrade Your Skills!', 'https://example.com/learning', 'C023'),
('A024', 'Furniture Discounts', 'Text', 'Upgrade Your Living Space!', 'https://example.com/furniture', 'C024'),
('A025', 'Gourmet Foods', 'Image', 'Taste the Best!', 'https://example.com/gourmet', 'C025'),
('A026', 'Photography Gear', 'Video', 'Capture Your Best Moments!', 'https://example.com/photography', 'C026'),
('A027', 'Kids Toys Sale', 'Text', 'Fun for All Ages!', 'https://example.com/toys', 'C027'),
('A028', 'Music Instruments', 'Image', 'Play Your Heart Out!', 'https://example.com/music', 'C028'),
('A029', 'Gadgets & Accessories', 'Text', 'Latest Tech Trends!', 'https://example.com/gadgets', 'C029'),
('A030', 'Sports Equipment', 'Image', 'Gear Up for Victory!', 'https://example.com/sports', 'C030'),
('A031', 'Grocery Deals', 'Text', 'Fresh and Affordable!', 'https://example.com/grocery', 'C031'),
('A032', 'Streaming Services', 'Video', 'Watch Your Favorites!', 'https://example.com/streaming', 'C032'),
('A033', 'Gift Ideas', 'Image', 'Find the Perfect Gift!', 'https://example.com/gifts', 'C033'),
('A034', 'Travel Insurance', 'Text', 'Travel with Peace of Mind!', 'https://example.com/insurance', 'C034'),
('A035', 'DIY Tools', 'Image', 'Get Creative with DIY!', 'https://example.com/diy', 'C035'),
('A036', 'Financial Services', 'Text', 'Secure Your Future!', 'https://example.com/finance', 'C036'),
('A037', 'Dating App', 'Image', 'Find Your Match!', 'https://example.com/dating', 'C037'),
('A038', 'Freelance Work', 'Text', 'Find Your Next Gig!', 'https://example.com/freelance', 'C038'),
('A039', 'Mental Health Support', 'Image', 'Prioritize Your Well-being!', 'https://example.com/mentalhealth', 'C039'),
('A040', 'Career Coaching', 'Text', 'Boost Your Career!', 'https://example.com/career', 'C040'),
('A041', 'Electronics Clearance', 'Video', 'Huge Discounts Await!', 'https://example.com/electronics', 'C041'),
('A042', 'Gardening Supplies', 'Image', 'Grow Your Own Garden!', 'https://example.com/gardening', 'C042'),
('A043', 'Subscription Boxes', 'Text', 'Exciting Monthly Surprises!', 'https://example.com/subscriptions', 'C043'),
('A044', 'Virtual Reality', 'Image', 'Step into Another World!', 'https://example.com/vr', 'C044'),
('A045', 'Cycling Gear', 'Text', 'Ride with Comfort!', 'https://example.com/cycling', 'C045'),
('A046', 'Yoga Essentials', 'Image', 'Balance Your Life!', 'https://example.com/yoga', 'C046'),
('A047', 'Custom Merchandise', 'Text', 'Make It Yours!', 'https://example.com/custom', 'C047'),
('A048', 'Tech Startups', 'Image', 'Invest in the Future!', 'https://example.com/startups', 'C048'),
('A049', 'Online Coaching', 'Text', 'Learn Anytime, Anywhere!', 'https://example.com/coaching', 'C049'),
('A050', 'Luxury Travel', 'Video', 'Experience the Best!', 'https://example.com/luxurytravel', 'C050');


-- Keyword Table
INSERT INTO Keyword1  VALUES
('K001', 'discount offers', 'Broad'),
('K002', 'best deals', 'Phrase'),
('K003', 'tech gadgets', 'Exact'),
('K004', 'school supplies sale', 'Broad'),
('K005', 'Black Friday discounts', 'Exact'),
('K006', 'holiday discounts', 'Broad'),
('K007', 'cheap flights', 'Phrase'),
('K008', 'luxury watches', 'Exact'),
('K009', 'organic skincare', 'Broad'),
('K010', 'gaming laptops sale', 'Phrase'),
('K011', 'best smartphone deals', 'Exact'),
('K012', 'home decor ideas', 'Broad'),
('K013', 'fitness equipment', 'Phrase'),
('K014', 'cyber monday discounts', 'Exact'),
('K015', 'car accessories sale', 'Broad'),
('K016', 'pet supplies', 'Phrase'),
('K017', 'travel deals 2024', 'Exact'),
('K018', 'summer fashion', 'Broad'),
('K019', 'kids clothing offers', 'Phrase'),
('K020', 'electric vehicles', 'Exact'),
('K021', 'smart home gadgets', 'Broad'),
('K022', 'wedding accessories', 'Phrase'),
('K023', 'online learning courses', 'Exact'),
('K024', 'back to school deals', 'Broad'),
('K025', 'health insurance plans', 'Phrase'),
('K026', 'holiday travel packages', 'Exact'),
('K027', 'work from home essentials', 'Broad'),
('K028', 'tech startup funding', 'Phrase'),
('K029', 'best tablets under 500', 'Exact'),
('K030', 'investment strategies', 'Broad'),
('K031', 'high yield savings accounts', 'Phrase'),
('K032', 'best credit card rewards', 'Exact'),
('K033', 'solar energy solutions', 'Broad'),
('K034', 'kitchen appliance deals', 'Phrase'),
('K035', 'top-rated headphones', 'Exact'),
('K036', 'home security systems', 'Broad'),
('K037', 'gardening supplies', 'Phrase'),
('K038', 'smart fitness trackers', 'Exact'),
('K039', 'furniture clearance sale', 'Broad'),
('K040', 'best VPN services', 'Phrase'),
('K041', 'cloud storage providers', 'Exact'),
('K042', 'professional photography gear', 'Broad'),
('K043', 'office furniture discounts', 'Phrase'),
('K044', 'luxury handbags sale', 'Exact'),
('K045', 'fine jewelry discounts', 'Broad'),
('K046', 'student laptop offers', 'Phrase'),
('K047', 'outdoor adventure gear', 'Exact'),
('K048', 'art supplies for sale', 'Broad'),
('K049', 'electric bike deals', 'Phrase'),
('K050', 'home workout routines', 'Exact');



-- Audience Table
INSERT INTO Audience1 VALUES
('AU001', 'Young Shoppers', 'Ages 18-25, interested in fashion'),
('AU002', 'Tech Enthusiasts', 'Frequent buyers of electronics'),
('AU003', 'Parents', 'Looking for school-related products'),
('AU004', 'Deal Hunters', 'Responds well to heavy discounts'),
('AU005', 'Luxury Shoppers', 'High-income individuals seeking premium products'),
('AU006', 'Frequent Travelers', 'People who travel often for work or leisure'),
('AU007', 'Health Conscious', 'Individuals focused on fitness and wellness'),
('AU008', 'Home Decor Lovers', 'Interested in interior design and home improvement'),
('AU009', 'Pet Owners', 'People who own pets and buy pet-related products'),
('AU010', 'Gaming Enthusiasts', 'Regular buyers of video games and accessories'),
('AU011', 'Book Readers', 'People interested in purchasing books and ebooks'),
('AU012', 'Outdoor Adventurers', 'People who enjoy hiking, camping, and outdoor activities'),
('AU013', 'College Students', 'Young adults pursuing higher education'),
('AU014', 'Business Professionals', 'Working professionals interested in career growth'),
('AU015', 'Home Cooks', 'People interested in cooking and kitchen gadgets'),
('AU016', 'Fashion Trendsetters', 'Those who closely follow fashion trends'),
('AU017', 'DIY Enthusiasts', 'People who enjoy DIY projects and crafts'),
('AU018', 'Eco-Friendly Consumers', 'Consumers interested in sustainable and green products'),
('AU019', 'Parents of Toddlers', 'Parents with young children, ages 1-4'),
('AU020', 'Sports Fans', 'People who actively follow and watch sports'),
('AU021', 'Luxury Car Buyers', 'Individuals interested in high-end automobiles'),
('AU022', 'Budget Shoppers', 'Consumers who actively seek deals and discounts'),
('AU023', 'Tech Geeks', 'Early adopters of the latest technology'),
('AU024', 'Freelancers', 'Self-employed professionals looking for work solutions'),
('AU025', 'Music Lovers', 'People who frequently buy or stream music'),
('AU026', 'Coffee Enthusiasts', 'Consumers who are passionate about coffee brewing'),
('AU027', 'Fitness Freaks', 'People who regularly engage in fitness activities'),
('AU028', 'Online Gamers', 'Individuals who actively play online multiplayer games'),
('AU029', 'New Homeowners', 'People who have recently purchased a home'),
('AU030', 'Senior Citizens', 'Older adults looking for lifestyle and healthcare products'),
('AU031', 'Vegan Consumers', 'People who follow a vegan diet and lifestyle'),
('AU032', 'Adventure Travelers', 'People interested in adventure tourism and experiences'),
('AU033', 'Investment Seekers', 'Individuals looking for investment opportunities'),
('AU034', 'Photography Enthusiasts', 'Hobbyists and professionals interested in cameras and accessories'),
('AU035', 'Remote Workers', 'People working from home or in hybrid work settings'),
('AU036', 'Streaming Addicts', 'Consumers who frequently watch streaming services'),
('AU037', 'Parents of Teens', 'Parents with teenage children, ages 13-19'),
('AU038', 'Foodies', 'People who enjoy exploring new cuisines and dining experiences'),
('AU039', 'Sustainable Living Advocates', 'Individuals focused on reducing environmental impact'),
('AU040', 'Frequent Shoppers', 'People who shop online or in-store frequently'),
('AU041', 'Small Business Owners', 'Entrepreneurs managing small-scale businesses'),
('AU042', 'Art Collectors', 'People who purchase fine art and collectibles'),
('AU043', 'DIY Home Renovators', 'Individuals interested in home renovation projects'),
('AU044', 'Luxury Travelers', 'High-income individuals who travel in luxury'),
('AU045', 'Collectors', 'People who collect rare and unique items'),
('AU046', 'Car Enthusiasts', 'People who follow automobile trends and modifications'),
('AU047', 'Sustainable Fashion Buyers', 'Consumers who purchase ethical and sustainable clothing'),
('AU048', 'Young Parents', 'Parents with infants and young children'),
('AU049', 'Tech Investors', 'Individuals investing in technology startups and stocks'),
('AU050', 'Gaming Streamers', 'Content creators who stream gaming sessions online');


-- Ad Placement Table
INSERT INTO AdPlacement1 VALUES
('AP001', 'Search', 'Google Search'),
('AP002', 'Display', 'YouTube'),
('AP003', 'Video', 'Facebook Ads'),
('AP004', 'Search', 'Bing Search'),
('AP005', 'Display', 'Instagram Ads'),
('AP006', 'Video', 'TikTok Ads'),
('AP007', 'Search', 'Yahoo Search'),
('AP008', 'Display', 'Reddit Ads'),
('AP009', 'Video', 'Snapchat Ads'),
('AP010', 'Search', 'Google Search'),
('AP011', 'Display', 'YouTube'),
('AP012', 'Video', 'Facebook Ads'),
('AP013', 'Search', 'Bing Search'),
('AP014', 'Display', 'Instagram Ads'),
('AP015', 'Video', 'TikTok Ads'),
('AP016', 'Search', 'Yahoo Search'),
('AP017', 'Display', 'Reddit Ads'),
('AP018', 'Video', 'Snapchat Ads'),
('AP019', 'Search', 'Google Search'),
('AP020', 'Display', 'YouTube'),
('AP021', 'Video', 'Facebook Ads'),
('AP022', 'Search', 'Bing Search'),
('AP023', 'Display', 'Instagram Ads'),
('AP024', 'Video', 'TikTok Ads'),
('AP025', 'Search', 'Yahoo Search'),
('AP026', 'Display', 'Reddit Ads'),
('AP027', 'Video', 'Snapchat Ads'),
('AP028', 'Search', 'Google Search'),
('AP029', 'Display', 'YouTube'),
('AP030', 'Video', 'Facebook Ads'),
('AP031', 'Search', 'Bing Search'),
('AP032', 'Display', 'Instagram Ads'),
('AP033', 'Video', 'TikTok Ads'),
('AP034', 'Search', 'Yahoo Search'),
('AP035', 'Display', 'Reddit Ads'),
('AP036', 'Video', 'Snapchat Ads'),
('AP037', 'Search', 'Google Search'),
('AP038', 'Display', 'YouTube'),
('AP039', 'Video', 'Facebook Ads'),
('AP040', 'Search', 'Bing Search'),
('AP041', 'Display', 'Instagram Ads'),
('AP042', 'Video', 'TikTok Ads'),
('AP043', 'Search', 'Yahoo Search'),
('AP044', 'Display', 'Reddit Ads'),
('AP045', 'Video', 'Snapchat Ads'),
('AP046', 'Search', 'Google Search'),
('AP047', 'Display', 'YouTube'),
('AP048', 'Video', 'Facebook Ads'),
('AP049', 'Search', 'Bing Search'),
('AP050', 'Display', 'Instagram Ads');

-- Performance Metrics Table
INSERT INTO PerformanceMetrics1 VALUES
('PM001', 10000, 500, 50, 0.50, 'A001'),
('PM002', 15000, 750, 80, 0.40, 'A002'),
('PM003', 20000, 1200, 150, 0.35, 'A003'),
('PM004', 12000, 600, 70, 0.45, 'A004'),
('PM005', 8000, 300, 40, 0.55, 'A005'),
('PM006', 9500, 450, 45, 0.52, 'A006'),
('PM007', 17000, 900, 100, 0.38, 'A007'),
('PM008', 11000, 550, 60, 0.48, 'A008'),
('PM009', 22000, 1300, 160, 0.33, 'A009'),
('PM010', 13000, 650, 75, 0.43, 'A010'),
('PM011', 14000, 700, 85, 0.42, 'A011'),
('PM012', 21000, 1250, 155, 0.34, 'A012'),
('PM013', 9000, 400, 42, 0.53, 'A013'),
('PM014', 16000, 850, 90, 0.39, 'A014'),
('PM015', 12000, 600, 72, 0.46, 'A015'),
('PM016', 19500, 1000, 140, 0.36, 'A016'),
('PM017', 11500, 580, 65, 0.47, 'A017'),
('PM018', 8500, 350, 38, 0.54, 'A018'),
('PM019', 18000, 950, 110, 0.37, 'A019'),
('PM020', 17500, 920, 105, 0.37, 'A020'),
('PM021', 20000, 1100, 135, 0.35, 'A021'),
('PM022', 12500, 620, 78, 0.44, 'A022'),
('PM023', 19000, 970, 120, 0.36, 'A023'),
('PM024', 15500, 810, 95, 0.40, 'A024'),
('PM025', 10500, 530, 62, 0.49, 'A025'),
('PM026', 9800, 490, 55, 0.51, 'A026'),
('PM027', 20500, 1150, 145, 0.34, 'A027'),
('PM028', 13500, 670, 82, 0.42, 'A028'),
('PM029', 14200, 720, 88, 0.41, 'A029'),
('PM030', 12700, 640, 77, 0.44, 'A030'),
('PM031', 16500, 860, 98, 0.39, 'A031'),
('PM032', 10800, 540, 63, 0.48, 'A032'),
('PM033', 14800, 750, 92, 0.40, 'A033'),
('PM034', 21000, 1180, 150, 0.34, 'A034'),
('PM035', 9000, 420, 46, 0.52, 'A035'),
('PM036', 18700, 940, 115, 0.37, 'A036'),
('PM037', 11900, 590, 70, 0.46, 'A037'),
('PM038', 14000, 730, 89, 0.41, 'A038'),
('PM039', 15500, 800, 93, 0.40, 'A039'),
('PM040', 11200, 560, 67, 0.47, 'A040'),
('PM041', 16800, 870, 102, 0.38, 'A041'),
('PM042', 9700, 480, 54, 0.51, 'A042'),
('PM043', 20700, 1160, 148, 0.34, 'A043'),
('PM044', 12800, 650, 79, 0.44, 'A044'),
('PM045', 13500, 700, 86, 0.42, 'A045'),
('PM046', 12300, 630, 75, 0.45, 'A046'),
('PM047', 16000, 830, 97, 0.39, 'A047'),
('PM048', 11000, 550, 64, 0.48, 'A048'),
('PM049', 14500, 760, 91, 0.40, 'A049'),
('PM050', 21200, 1200, 155, 0.34, 'A050');


-- Budget Allocation Table
INSERT INTO BudgetAllocation1 VALUES
('BA001', 5000.00, 3000.00, 'C001'),
('BA002', 7000.00, 5000.00, 'C002'),
('BA003', 4500.00, 2000.00, 'C003'),
('BA004', 8000.00, 6000.00, 'C004'),
('BA005', 12000.00, 10000.00, 'C005'),
('BA006', 5300.00, 3100.00, 'C006'),
('BA007', 7200.00, 5100.00, 'C007'),
('BA008', 4600.00, 2100.00, 'C008'),
('BA009', 8100.00, 6200.00, 'C009'),
('BA010', 12500.00, 10200.00, 'C010'),
('BA011', 4900.00, 2900.00, 'C011'),
('BA012', 6800.00, 4800.00, 'C012'),
('BA013', 4400.00, 1900.00, 'C013'),
('BA014', 7900.00, 5800.00, 'C014'),
('BA015', 11800.00, 9800.00, 'C015'),
('BA016', 5100.00, 3000.00, 'C016'),
('BA017', 7100.00, 4900.00, 'C017'),
('BA018', 4700.00, 2200.00, 'C018'),
('BA019', 8300.00, 6400.00, 'C019'),
('BA020', 12600.00, 10400.00, 'C020'),
('BA021', 5000.00, 2800.00, 'C021'),
('BA022', 6750.00, 4600.00, 'C022'),
('BA023', 4300.00, 1850.00, 'C023'),
('BA024', 7700.00, 5600.00, 'C024'),
('BA025', 11700.00, 9600.00, 'C025'),
('BA026', 5400.00, 3200.00, 'C026'),
('BA027', 7400.00, 5200.00, 'C027'),
('BA028', 4800.00, 2300.00, 'C028'),
('BA029', 8500.00, 6600.00, 'C029'),
('BA030', 12800.00, 10600.00, 'C030'),
('BA031', 5200.00, 3100.00, 'C031'),
('BA032', 7300.00, 5000.00, 'C032'),
('BA033', 4600.00, 2150.00, 'C033'),
('BA034', 8000.00, 6000.00, 'C034'),
('BA035', 12100.00, 9900.00, 'C035'),
('BA036', 5300.00, 3150.00, 'C036'),
('BA037', 7500.00, 5300.00, 'C037'),
('BA038', 4700.00, 2250.00, 'C038'),
('BA039', 8700.00, 6800.00, 'C039'),
('BA040', 13000.00, 10800.00, 'C040'),
('BA041', 5600.00, 3300.00, 'C041'),
('BA042', 7700.00, 5500.00, 'C042'),
('BA043', 4900.00, 2400.00, 'C043'),
('BA044', 8800.00, 6900.00, 'C044'),
('BA045', 13300.00, 11100.00, 'C045'),
('BA046', 5700.00, 3400.00, 'C046'),
('BA047', 7900.00, 5700.00, 'C047'),
('BA048', 5000.00, 2500.00, 'C048'),
('BA049', 8900.00, 7000.00, 'C049'),
('BA050', 13500.00, 11300.00, 'C050');


-- Junction Tables
-- AdGroupKeyword Table
INSERT INTO AdPlacementTracking1 VALUES
('A001', 'AP001'), ('A002', 'AP002'), ('A003', 'AP003'), ('A004', 'AP004'),
('A005', 'AP005'), ('A006', 'AP006'), ('A007', 'AP007'), ('A008', 'AP008'),
('A009', 'AP009'), ('A010', 'AP010'), ('A011', 'AP011'), ('A012', 'AP012'),
('A013', 'AP013'), ('A014', 'AP014'), ('A015', 'AP015'), ('A016', 'AP016'),
('A017', 'AP017'), ('A018', 'AP018'), ('A019', 'AP019'), ('A020', 'AP020'),
('A021', 'AP021'), ('A022', 'AP022'), ('A023', 'AP023'), ('A024', 'AP024'),
('A025', 'AP025'), ('A026', 'AP026'), ('A027', 'AP027'), ('A028', 'AP028'),
('A029', 'AP029'), ('A030', 'AP030'), ('A031', 'AP031'), ('A032', 'AP032'),
('A033', 'AP033'), ('A034', 'AP034'), ('A035', 'AP035'), ('A036', 'AP036'),
('A037', 'AP037'), ('A038', 'AP038'), ('A039', 'AP039'), ('A040', 'AP040'),
('A041', 'AP041'), ('A042', 'AP042'), ('A043', 'AP043'), ('A044', 'AP044'),
('A045', 'AP045'), ('A046', 'AP046'), ('A047', 'AP047'), ('A048', 'AP048'),
('A049', 'AP049'), ('A050', 'AP050');



-- CampaignAudience Table
INSERT INTO CampaignAudience1 VALUES
('C001', 'AU001'),
('C002', 'AU002'),
('C003', 'AU003'),
('C004', 'AU004'),
('C005', 'AU005'),
('C001', 'AU006'),
('C002', 'AU007'),
('C003', 'AU008'),
('C004', 'AU009'),
('C005', 'AU010'),
('C001', 'AU011'),
('C002', 'AU012'),
('C003', 'AU013'),
('C004', 'AU014'),
('C005', 'AU015'),
('C001', 'AU016'),
('C002', 'AU017'),
('C003', 'AU018'),
('C004', 'AU019'),
('C005', 'AU020'),
('C001', 'AU021'),
('C002', 'AU022'),
('C003', 'AU023'),
('C004', 'AU024'),
('C005', 'AU025'),
('C001', 'AU026'),
('C002', 'AU027'),
('C003', 'AU028'),
('C004', 'AU029'),
('C005', 'AU030'),
('C001', 'AU031'),
('C002', 'AU032'),
('C003', 'AU033'),
('C004', 'AU034'),
('C005', 'AU035'),
('C001', 'AU036'),
('C002', 'AU037'),
('C003', 'AU038'),
('C004', 'AU039'),
('C005', 'AU040'),
('C001', 'AU041'),
('C002', 'AU042'),
('C003', 'AU043'),
('C004', 'AU044'),
('C005', 'AU045'),
('C001', 'AU046'),
('C002', 'AU047'),
('C003', 'AU048'),
('C004', 'AU049'),
('C005', 'AU050');

select * from CampaignAudience1 ;

-- AdPlacementTracking Table 
INSERT INTO AdGroupKeyword1 VALUES
('AG001', 'K001'), ('AG002', 'K002'), ('AG003', 'K003'), ('AG004', 'K004'),
('AG005', 'K005'), ('AG006', 'K006'), ('AG007', 'K007'), ('AG008', 'K008'),
('AG009', 'K009'), ('AG010', 'K010'), ('AG011', 'K011'), ('AG012', 'K012'),
('AG013', 'K013'), ('AG014', 'K014'), ('AG015', 'K015'), ('AG016', 'K016'),
('AG017', 'K017'), ('AG018', 'K018'), ('AG019', 'K019'), ('AG020', 'K020'),
('AG021', 'K021'), ('AG022', 'K022'), ('AG023', 'K023'), ('AG024', 'K024'),
('AG025', 'K025'), ('AG026', 'K026'), ('AG027', 'K027'), ('AG028', 'K028'),
('AG029', 'K029'), ('AG030', 'K030'), ('AG031', 'K031'), ('AG032', 'K032'),
('AG033', 'K033'), ('AG034', 'K034'), ('AG035', 'K035'), ('AG036', 'K036'),
('AG037', 'K037'), ('AG038', 'K038'), ('AG039', 'K039'), ('AG040', 'K040'),
('AG041', 'K041'), ('AG042', 'K042'), ('AG043', 'K043'), ('AG044', 'K044'),
('AG045', 'K045'), ('AG046', 'K046'), ('AG047', 'K047'), ('AG048', 'K048'),
('AG049', 'K049'), ('AG050', 'K050');


select * from AdGroupKeyword1;
show tables;

-- dropping tables which are not in normal form : 
drop table Ad, adgroup, adgroupkeyword, adplacement, adplacementtracking,  audience, budgetallocation, campaign, campaignaudience, keyword, performancemetrics;

show tables;


-- FINAL STEP - STRESS TESTING : 

-- 1. Inserting Large Volumes of Data
INSERT INTO AdGroupKeyword1 (ad_group_id, keyword_id)
SELECT DISTINCT ad_group_id, keyword_id
FROM (
    SELECT 
        (SELECT ad_group_id FROM AdGroup1 ORDER BY RAND() LIMIT 1) AS ad_group_id,
        (SELECT keyword_id FROM Keyword1 ORDER BY RAND() LIMIT 1) AS keyword_id
    FROM information_schema.tables
    LIMIT 100000
) AS temp
WHERE NOT EXISTS (
    SELECT 1 FROM AdGroupKeyword1 
    WHERE AdGroupKeyword1.ad_group_id = temp.ad_group_id 
      AND AdGroupKeyword1.keyword_id = temp.keyword_id
);

Select * from AdGroupKeyword1;


-- 2. Running Concurrent Queries
SELECT BENCHMARK(1000000, (SELECT COUNT(*) FROM AdGroupKeyword1));


-- 3. Measuring Query Performance
-- Query execution time : 
EXPLAIN ANALYZE 
SELECT * FROM AdGroupKeyword1 WHERE ad_group_id = 'AG500';

-- Enable query profiling : 
SET profiling = 1;
SELECT * FROM AdGroupKeyword1 WHERE keyword_id = 'K500';
SHOW PROFILES;


-- 4. Simulating transactions under load 
START TRANSACTION;
UPDATE BudgetAllocation1 SET spent_budget = spent_budget + 100 WHERE campaign_id = 'C001';
SELECT * FROM BudgetAllocation1 WHERE campaign_id = 'C001' FOR UPDATE;
COMMIT;


-- 5. Checking system performance (CPU, RAM, Disk Usage)
SELECT * FROM performance_schema.events_statements_summary_by_digest ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;


-- 6. Optimizing based ion results
CREATE INDEX idx_adgroup_keyword ON AdGroupKeyword1(ad_group_id, keyword_id);

-- END --
