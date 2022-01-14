import {ButtonIconPlacement, ButtonSize, ButtonVariant} from "components/Button/types";

export const buttonVariant:ButtonVariant[] = ['primary', 'secondary', 'tertiary', 'brand', 'ghost'];
export const buttonSizes:ButtonSize[] = ['huge', 'large', 'medium', 'small'];
export const buttonIconPlacements:ButtonIconPlacement[] = ['leading', 'trailing', 'only'];

export const variantUsage = (variant: ButtonVariant):string => {
  switch (variant) {
    case 'primary':
      return 'Default value.';
    default:
      return '-';
  }
}

export const sizeUsage = (size: ButtonSize):string => {
  switch (size) {
    case 'huge':
      return 'Is only allowed with `primary` variant.';
    case 'medium':
      return 'Default value.';
    default:
      return '-';
  }
}

export const iconPlacementUsage = (placement: ButtonIconPlacement):string => {
  switch (placement) {
    case 'only':
      return 'Is not allowed with `small` size.';
    case 'leading':
      return 'Default value.';
    default:
      return '-';
  }
}