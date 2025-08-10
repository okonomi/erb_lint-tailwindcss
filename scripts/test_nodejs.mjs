#!/usr/bin/env node

/**
 * Test script to verify Node.js environment and prettier-plugin-tailwindcss
 */

console.log('=== Node.js Environment Test ===');
console.log(`Node.js version: ${process.version}`);

try {
  // Test that prettier-plugin-tailwindcss can be imported
  const prettierPluginTailwindcss = await import('prettier-plugin-tailwindcss');
  console.log('✅ prettier-plugin-tailwindcss loaded successfully');
  
  // Check if the plugin has expected exports
  if (prettierPluginTailwindcss.default) {
    console.log('✅ Plugin default export available');
  }
  
  console.log('Available exports:', Object.keys(prettierPluginTailwindcss));
} catch (error) {
  console.error('❌ Failed to load prettier-plugin-tailwindcss:', error.message);
  process.exit(1);
}

console.log('✅ Node.js environment setup complete');