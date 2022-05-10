import colorTokens from '@primauk/tokens/json/colors.json';

declare global {
  type Color = keyof (typeof colorTokens);
}
