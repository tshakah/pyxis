import elevationColorTokens from '@pyxis/tokens/json/elevation/colors.json';
import elevationSizeTokens from '@pyxis/tokens/json/elevation/sizes.json';

declare global {
  export type ElevationSize = keyof (typeof elevationSizeTokens)
  export type ElevationColor = keyof (typeof elevationColorTokens)
}
