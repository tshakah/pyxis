import {
  AnchorHTMLAttributes, ButtonHTMLAttributes, FC, ReactElement,
} from 'react';
import { IconProps } from 'components/Icon';

type ButtonSize
  = 'huge'
  | 'large'
  | 'medium'
  | 'small'

type ButtonVariant
  = 'primary'
  | 'secondary'
  | 'tertiary'
  | 'brand'
  | 'ghost'

type ButtonIconPlacement
  = 'leading'
  | 'trailing'
  | 'only'

type SizeCheck<S, V> =
  S extends 'huge'
    ? V extends 'primary'
      ? S
      : ['size `huge` can only be used with `primary` variant']
    : S

type ShadowCheck<V> =
  V extends 'primary'
    ? boolean
    : V extends 'brand'
      ? boolean
      : 'shadow can only be used with `primary` or `brand` variant'

type LoadingCheck<S, V> =
  S extends 'small'
    ? 'loading cannot be used with `small` size'
    : V extends 'ghost'
      ? 'loading cannot be used with `ghost` variant'
      : boolean

type ContentWidthCheck<V, I> =
  V extends 'ghost'
    ? 'contentWidth cannot be used with `ghost` variant'
    : I extends 'only'
      ? 'contentWidth cannot be used with iconPlacement `only`'
      : boolean

type IconPlacementCheck<I, S> =
  S extends 'small'
    ? 'iconPlacement `only` cannot be used with small size'
    : I

interface BaseProps<S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement> {
  alt?: boolean;
  children: string;
  contentWidth?: ContentWidthCheck<V, I>
  icon?: FC<IconProps>
  iconPlacement?: IconPlacementCheck<I, S>;
  loading?: LoadingCheck<S, V>;
  shadow?: ShadowCheck<V>;
  size?: SizeCheck<S, V>;
  variant?: V;
}

type CommonButtonProps<S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement> =
  BaseProps<S, V, I> & ButtonHTMLAttributes<HTMLButtonElement>

type CommonAnchorProps<S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement> =
  BaseProps<S, V, I> & AnchorHTMLAttributes<HTMLAnchorElement>

type ButtonProps<S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement> =
  CommonButtonProps<S, V, I> | CommonAnchorProps<S, V, I>;

type ButtonFC = <S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement>(props: ButtonProps<S, V, I>) =>
  ReactElement<ButtonProps<S, V, I>>;

interface ButtonContentProps {
  icon?: FC<IconProps>,
  children: string,
  iconPlacement: ButtonIconPlacement,
  size: ButtonSize,
}

const isAnchor = <S extends ButtonSize, V extends ButtonVariant, I extends ButtonIconPlacement>(
  props:CommonButtonProps<S, V, I> | CommonAnchorProps<S, V, I>,
): props is CommonAnchorProps<S, V, I> => (props as CommonAnchorProps<S, V, I>).href !== undefined;

export { isAnchor };

export type {
  ButtonFC,
  ButtonIconPlacement,
  ButtonProps,
  ButtonSize,
  ButtonVariant,
  ButtonContentProps,
};
