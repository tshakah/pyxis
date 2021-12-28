import gradientTokens from '@pyxis/tokens/json/gradients.json';

declare global {
  type Gradient = keyof (typeof gradientTokens);
}
