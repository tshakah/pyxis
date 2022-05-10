import gradientTokens from '@primauk/tokens/json/gradients.json';

declare global {
  type Gradient = keyof (typeof gradientTokens);
}
