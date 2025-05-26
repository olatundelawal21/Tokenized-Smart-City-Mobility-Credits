# Tokenized Smart City Mobility Credits System

A blockchain-based platform that incentivizes sustainable transportation choices through tokenized mobility credits. Citizens earn rewards for using eco-friendly transportation options and can redeem these credits for various mobility services and benefits.

## 🚀 Overview

The Smart City Mobility Credits System revolutionizes urban transportation by creating a transparent, gamified ecosystem that rewards sustainable mobility choices. By leveraging blockchain technology and smart contracts, the platform ensures fair credit distribution, prevents fraud, and provides real-time optimization of incentive structures.

## 🏗️ System Architecture

The platform consists of five interconnected smart contracts working together to create a comprehensive mobility reward ecosystem:

### 1. Transportation Verification Contract
- **Purpose**: Validates and authenticates mobility services and user activities
- **Features**:
    - Real-time GPS tracking validation
    - Integration with IoT sensors and city infrastructure
    - Multi-modal transportation verification (bike, e-scooter, public transit, walking)
    - Anti-fraud mechanisms and duplicate journey detection
    - Third-party service provider integration (Uber, Lyft, city transit)
    - Carbon footprint calculation and verification

### 2. Credit Issuance Contract
- **Purpose**: Creates and distributes mobility reward tokens based on verified activities
- **Features**:
    - Dynamic credit calculation based on distance, mode, and environmental impact
    - Tiered reward system for different transportation types
    - Bonus multipliers for peak hour usage and route optimization
    - Seasonal and event-based credit bonuses
    - Automated minting and distribution
    - Supply cap management and inflation control

### 3. Usage Tracking Contract
- **Purpose**: Monitors and analyzes sustainable transportation patterns
- **Features**:
    - Comprehensive journey logging and analytics
    - Real-time emissions tracking and reporting
    - User behavior pattern analysis
    - Route optimization suggestions
    - Peak hour usage monitoring
    - Integration with city traffic management systems
    - Privacy-preserving data aggregation

### 4. Redemption Contract
- **Purpose**: Manages credit utilization and exchange for services/benefits
- **Features**:
    - Multi-category redemption options (transit passes, bike rentals, parking)
    - Dynamic pricing based on demand and availability
    - Partner merchant integration
    - Instant redemption processing
    - Credit transfer and gifting capabilities
    - Expiration management and rollover policies

### 5. Incentive Optimization Contract
- **Purpose**: Dynamically adjusts reward structures based on city goals and usage patterns
- **Features**:
    - AI-driven incentive adjustment algorithms
    - Real-time demand balancing across transportation modes
    - Seasonal and event-based optimization
    - City policy integration and compliance
    - A/B testing framework for incentive strategies
    - Predictive modeling for transportation demand

## 🎯 Key Benefits

### For Citizens
- **Earn While You Move**: Get rewarded for sustainable transportation choices
- **Flexible Redemption**: Use credits for various mobility services and city amenities
- **Gamification**: Track progress, achievements, and compete with others
- **Cost Savings**: Reduce transportation expenses through earned credits

### For Cities
- **Reduced Emissions**: Incentivize low-carbon transportation options
- **Traffic Optimization**: Balance demand across different transport modes
- **Data Insights**: Real-time analytics on citizen mobility patterns
- **Economic Efficiency**: Dynamic pricing and resource allocation

### For Service Providers
- **Customer Acquisition**: Attract users through integrated reward system
- **Data Analytics**: Access to aggregated usage patterns and trends
- **Revenue Optimization**: Dynamic pricing integration
- **Brand Enhancement**: Association with sustainability initiatives

## 🚀 Getting Started

### Prerequisites

- Node.js (v18.0.0 or higher)
- Ethereum development environment (Hardhat recommended)
- Web3 wallet (MetaMask or WalletConnect compatible)
- GPS-enabled mobile device or IoT integration
- City infrastructure API access (optional but recommended)

### Installation

```bash
# Clone the repository
git clone https://github.com/smart-city/mobility-credits-blockchain.git
cd mobility-credits-blockchain

# Install core dependencies
npm install

# Install blockchain development tools
npm install @openzeppelin/contracts hardhat @nomiclabs/hardhat-ethers ethers

# Install IoT and API integration packages
npm install axios mqtt ws geolib

# Install analytics and optimization libraries
npm install @tensorflow/tfjs lodash moment
```

### Environment Configuration

Create a `.env` file with the following configuration:

```env
# Blockchain Network Settings
NETWORK_URL=https://your-ethereum-rpc-url
PRIVATE_KEY=your-deployment-private-key
POLYGON_RPC_URL=https://polygon-rpc.com
BSC_RPC_URL=https://bsc-dataseed.binance.org

# Contract Addresses (populated after deployment)
TRANSPORT_VERIFICATION_ADDRESS=
CREDIT_ISSUANCE_ADDRESS=
USAGE_TRACKING_ADDRESS=
REDEMPTION_ADDRESS=
INCENTIVE_OPTIMIZATION_ADDRESS=

# API Integration
GOOGLE_MAPS_API_KEY=your-google-maps-key
CITY_TRANSIT_API_KEY=your-transit-api-key
WEATHER_API_KEY=your-weather-api-key
IOT_MQTT_BROKER=mqtt://your-iot-broker

# Database Configuration
DATABASE_URL=postgresql://user:password@localhost:5432/mobility_credits
REDIS_URL=redis://localhost:6379

# Mobile App Integration
FIREBASE_PROJECT_ID=your-firebase-project
FIREBASE_API_KEY=your-firebase-key
PUSH_NOTIFICATION_KEY=your-push-key
```

### Smart Contract Deployment

```bash
# Compile all contracts
npx hardhat compile

# Deploy to local development network
npx hardhat run scripts/deploy-full-system.js --network localhost

# Deploy to Polygon testnet
npx hardhat run scripts/deploy-full-system.js --network mumbai

# Deploy to mainnet (production)
npx hardhat run scripts/deploy-full-system.js --network polygon

# Verify contracts on Polygonscan
npx hardhat verify --network polygon CONTRACT_ADDRESS "Constructor Args"
```

## 📱 Usage Examples

### 1. Registering a New User

```javascript
// Connect to the Transportation Verification Contract
const transportContract = await ethers.getContractAt("TransportationVerification", contractAddress);

// Register user with verification requirements
await transportContract.registerUser(
  userAddress,
  {
    name: "John Doe",
    preferredModes: ["bike", "public_transit", "walking"],
    homeLocation: [40.7128, -74.0060], // NYC coordinates
    workLocation: [40.7589, -73.9851],
    verificationLevel: "standard" // or "premium" for enhanced features
  }
);
```

### 2. Verifying a Journey

```javascript
// Submit journey for verification and credit earning
const verificationContract = await ethers.getContractAt("TransportationVerification", contractAddress);

// Verify a bike journey
await verificationContract.verifyJourney(
  userAddress,
  {
    mode: "bike",
    startLocation: [40.7128, -74.0060],
    endLocation: [40.7589, -73.9851],
    startTime: Math.floor(Date.now() / 1000),
    endTime: Math.floor(Date.now() / 1000) + 1800, // 30-minute journey
    distance: 5.2, // kilometers
    gpsTrack: ipfsHashOfGPSData,
    carbonSaved: 2.1 // kg CO2 equivalent
  }
);
```

### 3. Earning Credits

```javascript
// Connect to Credit Issuance Contract
const creditContract = await ethers.getContractAt("CreditIssuance", contractAddress);

// Credits are automatically issued after journey verification
// Check user's credit balance
const balance = await creditContract.balanceOf(userAddress);
console.log(`Current credit balance: ${balance} MCT`);

// View earning history
const earnings = await creditContract.getEarningHistory(userAddress, 30); // last 30 days
```

### 4. Tracking Usage Patterns

```javascript
// Connect to Usage Tracking Contract
const trackingContract = await ethers.getContractAt("UsageTracking", contractAddress);

// Get user's transportation analytics
const analytics = await trackingContract.getUserAnalytics(userAddress);
console.log({
  totalDistance: analytics.totalDistance,
  carbonSaved: analytics.totalCarbonSaved,
  favoriteMode: analytics.mostUsedMode,
  weeklyPattern: analytics.weeklyUsagePattern
});

// Get city-wide transportation trends
const cityTrends = await trackingContract.getCityAnalytics();
```

### 5. Redeeming Credits

```javascript
// Connect to Redemption Contract
const redemptionContract = await ethers.getContractAt("Redemption", contractAddress);

// Browse available redemption options
const options = await redemptionContract.getRedemptionOptions();

// Redeem credits for a monthly transit pass
await redemptionContract.redeemCredits(
  userAddress,
  "monthly_transit_pass",
  1000, // credits to spend
  {
    validFrom: Math.floor(Date.now() / 1000),
    validUntil: Math.floor(Date.now() / 1000) + (30 * 24 * 3600),
    transitAuthority: "NYC_MTA"
  }
);
```

### 6. Dynamic Incentive Adjustment

```javascript
// Connect to Incentive Optimization Contract (admin function)
const optimizationContract = await ethers.getContractAt("IncentiveOptimization", contractAddress);

// AI-driven incentive adjustment based on current city conditions
await optimizationContract.optimizeIncentives(
  {
    currentTrafficLevel: "high",
    airQualityIndex: 95,
    publicTransitCapacity: 0.8,
    bikeAvailability: 0.6,
    weatherConditions: "clear",
    specialEvents: ["marathon_event"]
  }
);
```

## 🔧 API Reference

### Transportation Verification Contract

#### Core Functions
- `registerUser(address, userData)` - Register new platform user
- `verifyJourney(address, journeyData)` - Validate and process transportation activity
- `updateVerificationLevel(address, level)` - Upgrade user verification status
- `reportFraudulentActivity(journeyId, evidence)` - Report suspected fraud
- `getVerificationStatus(journeyId)` - Check journey verification status

#### Integration Functions
- `addServiceProvider(provider, permissions)` - Integrate third-party services
- `updateGPSValidation(config)` - Configure location verification parameters
- `setCarbonCalculationModel(model)` - Update emissions calculation methodology

### Credit Issuance Contract

#### Token Management
- `issueCredits(address, amount, reason)` - Mint new credits for verified activities
- `balanceOf(address)` - Check user's credit balance
- `transfer(from, to, amount)` - Transfer credits between users
- `burn(address, amount)` - Remove credits from circulation

#### Reward Configuration
- `setRewardRates(mode, baseRate, multipliers)` - Configure earning rates per transport mode
- `addBonusEvent(eventType, multiplier, duration)` - Create limited-time bonus campaigns
- `updateInflationControls(maxSupply, mintRate)` - Manage token economics

### Usage Tracking Contract

#### Analytics Functions
- `getUserAnalytics(address, timeframe)` - Retrieve user transportation patterns
- `getCityAnalytics(district, timeframe)` - Get aggregated city-wide data
- `getEmissionsSaved(timeframe, aggregation)` - Calculate environmental impact
- `generateReport(type, parameters)` - Create custom analytics reports

#### Privacy Controls
- `setDataRetention(duration)` - Configure data storage policies
- `anonymizeUserData(address)` - Remove personally identifiable information
- `exportUserData(address)` - GDPR-compliant data export

### Redemption Contract

#### Redemption Management
- `getRedemptionOptions(category, location)` - Browse available rewards
- `redeemCredits(user, option, amount, metadata)` - Process credit redemption
- `transferCredits(from, to, amount)` - Gift credits to other users
- `checkRedemptionStatus(transactionId)` - Verify redemption processing

#### Partner Integration
- `addRedemptionPartner(partner, terms, categories)` - Onboard new merchants
- `updatePartnerOffering(partner, newOptions)` - Modify available rewards
- `settlePartnerPayments(partner, period)` - Process partner compensation

### Incentive Optimization Contract

#### AI-Driven Optimization
- `optimizeIncentives(cityConditions)` - Automatically adjust rewards based on current conditions
- `runABTest(testConfig, duration)` - Execute incentive strategy experiments
- `getPredictiveModel(scenario)` - Access transportation demand forecasts
- `updateOptimizationGoals(cityGoals)` - Configure optimization objectives

#### Manual Controls
- `setEmergencyIncentives(scenario, rewards)` - Rapidly respond to city events
- `scheduledIncentiveChange(changes, timestamp)` - Plan future reward adjustments
- `revertToBaseline(duration)` - Reset to default incentive structure

## 🏙️ Smart City Integration

### IoT Device Integration

```javascript
// Example MQTT integration for bike-share systems
const mqtt = require('mqtt');
const client = mqtt.connect(process.env.IOT_MQTT_BROKER);

client.on('message', async (topic, message) => {
  if (topic === 'bikeshare/journey/complete') {
    const journeyData = JSON.parse(message.toString());
    
    // Automatically verify and reward bike-share usage
    await verifyAndRewardJourney(journeyData);
  }
});

async function verifyAndRewardJourney(data) {
  const verification = await transportContract.verifyJourney(
    data.userId,
    {
      mode: 'bike_share',
      startLocation: data.startDock,
      endLocation: data.endDock,
      duration: data.tripDuration,
      bikeId: data.bikeId
    }
  );
}
```

### Traffic Management Integration

```javascript
// Real-time traffic optimization
async function optimizeTrafficIncentives() {
  const trafficData = await cityAPI.getCurrentTrafficConditions();
  const transitCapacity = await transitAPI.getCurrentCapacity();
  
  // Dynamically adjust incentives based on real-time conditions
  await optimizationContract.optimizeIncentives({
    congestionLevel: trafficData.averageCongestion,
    transitLoad: transitCapacity.utilizationRate,
    alternativeAvailability: trafficData.alternativeRoutes,
    weatherImpact: trafficData.weatherFactor
  });
}

// Run optimization every 15 minutes
setInterval(optimizeTrafficIncentives, 15 * 60 * 1000);
```

## 📊 Analytics and Reporting

### Key Performance Indicators (KPIs)

#### Environmental Impact
- Total CO2 emissions reduced
- Air quality improvement metrics
- Sustainable transportation mode adoption rates
- Energy consumption reduction

#### User Engagement
- Daily/Monthly active users
- Average credits earned per user
- Redemption rate and frequency
- User retention and churn rates

#### Economic Metrics
- Total value of credits issued
- Partner transaction volumes
- Cost savings to users
- Revenue generated for partners

### Real-Time Dashboard

```javascript
// Example dashboard data aggregation
async function generateDashboardData() {
  const [
    userStats,
    environmentalImpact,
    economicMetrics,
    cityPerformance
  ] = await Promise.all([
    trackingContract.getUserStatistics(),
    trackingContract.getEnvironmentalImpact(),
    redemptionContract.getEconomicMetrics(),
    optimizationContract.getCityPerformance()
  ]);

  return {
    activeUsers: userStats.monthlyActive,
    totalCreditsIssued: creditContract.totalSupply(),
    co2Saved: environmentalImpact.totalCarbonSaved,
    popularModes: userStats.modeDistribution,
    redemptionTrends: economicMetrics.redemptionHistory,
    incentiveEffectiveness: cityPerformance.goalAchievement
  };
}
```

## 🔒 Security and Privacy

### Security Features
- **Multi-signature governance** for system parameter changes
- **Rate limiting** to prevent spam and abuse
- **Fraud detection algorithms** using machine learning
- **GPS spoofing protection** through multiple verification methods
- **Smart contract auditing** by certified security firms

### Privacy Protection
- **Zero-knowledge proofs** for sensitive location data
- **Data anonymization** for analytics and research
- **GDPR compliance** with right to deletion and data portability
- **Opt-in data sharing** with granular permission controls
- **Local data processing** to minimize data transmission

## 🌍 Sustainability Goals

### Environmental Objectives
- **25% reduction** in urban transportation emissions by 2025
- **40% increase** in public transit usage during peak hours
- **50% growth** in active transportation (walking, cycling)
- **Carbon neutrality** for participating transportation networks

### Social Impact Goals
- **Equitable access** across all income levels and neighborhoods
- **Accessibility features** for users with disabilities
- **Digital inclusion** programs for underserved communities
- **Educational initiatives** about sustainable transportation

## 🤝 Partnership Opportunities

### Transit Authorities
- Integration with existing fare systems
- Real-time capacity and schedule data sharing
- Joint marketing and user acquisition campaigns
- Policy alignment and regulatory compliance

### Mobility Service Providers
- API integration for seamless user experience
- Revenue sharing through credit redemption
- Data insights for service optimization
- Co-branded sustainability initiatives

### Local Businesses
- Credit redemption at partner locations
- Location-based incentives and promotions
- Community engagement programs
- Corporate sustainability partnerships

## 🚀 Roadmap

### Phase 1: Foundation (Q1-Q2 2024)
- Core smart contract deployment
- Basic mobile app launch
- Pilot program with select partners
- Initial user onboarding (1,000 users)

### Phase 2: Expansion (Q3-Q4 2024)
- AI-driven incentive optimization
- Advanced analytics dashboard
- Multi-city deployment
- Partnership network growth (50+ partners)

### Phase 3: Innovation (Q1-Q2 2025)
- Cross-chain interoperability
- NFT achievements and gamification
- Predictive modeling integration
- International expansion

### Phase 4: Ecosystem (Q3-Q4 2025)
- Open API for third-party developers
- DeFi integration (staking, yield farming)
- Carbon credit marketplace
- Autonomous vehicle integration

## 🛠️ Development and Testing

### Testing Framework

```bash
# Run comprehensive test suite
npm run test

# Test individual contracts
npx hardhat test test/TransportationVerification.test.js
npx hardhat test test/CreditIssuance.test.js
npx hardhat test test/UsageTracking.test.js
npx hardhat test test/Redemption.test.js
npx hardhat test test/IncentiveOptimization.test.js

# Integration testing
npm run test:integration

# Load testing for scalability
npm run test:load

# Security testing
npm run test:security
```

### Code Quality

```bash
# Linting and formatting
npm run lint
npm run prettier

# Gas optimization analysis
npx hardhat run scripts/gas-analysis.js

# Contract size optimization
npx hardhat compile --optimizer

# Static analysis for vulnerabilities
npx slither .
```

## 📖 Documentation

### Developer Resources
- [Smart Contract API Documentation](./docs/api/)
- [Mobile SDK Integration Guide](./docs/mobile-sdk/)
- [Partner Integration Handbook](./docs/partners/)
- [City Administrator Manual](./docs/admin/)

### Research and Whitepapers
- [Tokenomics and Economic Model](./docs/tokenomics.pdf)
- [Privacy and Security Architecture](./docs/security-whitepaper.pdf)
- [Environmental Impact Methodology](./docs/environmental-impact.pdf)
- [AI Optimization Algorithms](./docs/ai-optimization.pdf)

## 📞 Support and Community

### Technical Support
- **Email**: developers@mobility-credits.org
- **Discord**: [Smart City Developers](https://discord.gg/smart-city-devs)
- **Stack Overflow**: Tag questions with `mobility-credits`
- **GitHub Issues**: Report bugs and feature requests

### Community Resources
- **Official Blog**: [blog.mobility-credits.org](https://blog.mobility-credits.org)
- **Twitter**: [@MobilityCredits](https://twitter.com/MobilityCredits)
- **LinkedIn**: [Smart City Mobility Network](https://linkedin.com/company/mobility-credits)
- **Telegram**: [Community Chat](https://t.me/mobility_credits)

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **City Transportation Departments** for partnership and data sharing
- **Environmental Research Organizations** for carbon calculation methodologies
- **Blockchain Security Auditors** for smart contract validation
- **Open Source Community** for foundational tools and libraries
- **Early Adopter Cities** for pilot program participation

---

**Building sustainable cities, one journey at a time. Join the mobility revolution! 🚲🚌🚶‍♀️**
