module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  transform: {
    '^.+\\.tsx?$': ['ts-jest', {
      tsconfig: 'tsconfig.json',
    }],
  },
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['json', 'lcov', 'text', 'clover'],
  testMatch: ['**/*.test.ts'],
  testPathIgnorePatterns: ['/node_modules/'],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
  // Add timeout setting
  testTimeout: 5000,
  // Add coverage thresholds
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  reporters: [
    'default',
    ['jest-junit', {
      outputDirectory: './test-results/junit',
      outputName: 'junit.xml',
    }],
    ['jest-html-reporter', {
      outputPath: './test-results/html-report.html',
      pageTitle: 'Test Report'
    }]
  ],
  // Add setup files if needed
  // setupFilesAfterEnv: ['<rootDir>/jest.setup.ts']
};