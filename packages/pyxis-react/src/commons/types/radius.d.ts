import radiusTokens from '@pyxis/tokens/json/radius.json';

declare global {
  type RadiusSize = keyof (typeof radiusTokens);
  type RadiusEdge = 'all' | 'right' | 'top' | 'left' | 'bottom';
}
