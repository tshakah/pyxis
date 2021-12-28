import colorTokens from '@pyxis/tokens/json/colors.json';

declare global {
  type Color = keyof (typeof colorTokens);
}
