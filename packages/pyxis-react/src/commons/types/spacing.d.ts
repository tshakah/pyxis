import spacingTokens from '@pyxis/tokens/json/spacings.json';

declare global {
  export type Spacing = keyof (typeof spacingTokens)
}
