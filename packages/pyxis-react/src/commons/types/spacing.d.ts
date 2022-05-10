import spacingTokens from '@primauk/tokens/json/spacings.json';

declare global {
  export type Spacing = keyof (typeof spacingTokens)
}
