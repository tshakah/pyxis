import { render, screen } from '@testing-library/react';
import { IconPen } from 'components/Icon/Icons';
import Button from './Button';

describe('Button component', () => {
  describe('with default options', () => {
    test('should render a primary variant with type submit and textual content', () => {
      render(<Button variant="primary" id="child-test">Primary</Button>);
      const button = screen.getByTestId('child-test');
      expect(button).toBeInTheDocument();
      expect(button).toHaveTextContent('Primary');
      expect(button).toHaveClass('button button--medium');
      expect(button).toHaveAttribute('type', 'submit');
    });
  });

  describe('has a variant option', () => {
    test('should be primary', () => {
      render(<Button variant="primary" id="variant-primary">Button</Button>);
      expect(screen.getByTestId('variant-primary')).toHaveClass('button--primary');
    });

    test('should be secondary', () => {
      render(<Button variant="secondary" id="variant-secondary">Button</Button>);
      expect(screen.getByTestId('variant-secondary')).toHaveClass('button--secondary');
    });

    test('should be tertiary', () => {
      render(<Button variant="tertiary" id="variant-tertiary">Button</Button>);
      expect(screen.getByTestId('variant-tertiary')).toHaveClass('button--tertiary');
    });

    test('should be brand', () => {
      render(<Button variant="brand" id="variant-brand">Button</Button>);
      expect(screen.getByTestId('variant-brand')).toHaveClass('button--brand');
    });

    test('should be ghost', () => {
      render(<Button variant="ghost" id="variant-ghost">Button</Button>);
      expect(screen.getByTestId('variant-ghost')).toHaveClass('button--ghost');
    });
  });

  describe('has a size option', () => {
    test('should be huge', () => {
      render(<Button variant="primary" size="huge" id="size-huge">Button</Button>);
      expect(screen.getByTestId('size-huge')).toHaveClass('button--huge');
    });

    test('should be large', () => {
      render(<Button variant="primary" size="large" id="size-large">Button</Button>);
      expect(screen.getByTestId('size-large')).toHaveClass('button--large');
    });

    test('should be medium', () => {
      render(<Button variant="primary" size="medium" id="size-medium">Button</Button>);
      expect(screen.getByTestId('size-medium')).toHaveClass('button--medium');
    });

    test('should be small', () => {
      render(<Button variant="primary" size="small" id="size-small">Button</Button>);
      expect(screen.getByTestId('size-small')).toHaveClass('button--small');
    });
  });

  describe('icon options', () => {
    test('should render the icon', () => {
      render(<Button variant="primary" icon={IconPen} id="icon-button">Button</Button>);
      const button = screen.getByTestId('icon-button');
      const icon = button.querySelector('svg');
      expect(button).toHaveClass('button--prepend-icon');
      expect(icon).toBeInTheDocument();
    });

    test('should be a prepend icon', () => {
      render(
        <Button variant="primary" icon={IconPen} iconPlacement="prepend" id="icon-prepend-button">Button</Button>,
      );
      const prepend = screen.getByTestId('icon-prepend-button');
      const prependIcon = prepend.querySelector('svg');
      expect(prepend).toHaveClass('button--prepend-icon');
      expect(prependIcon).toBeInTheDocument();
    });

    test('should be a append icon', () => {
      render(
        <Button variant="primary" icon={IconPen} iconPlacement="append" id="icon-append-button">Button</Button>,
      );
      const append = screen.getByTestId('icon-append-button');
      const appendIcon = append.querySelector('svg');
      expect(append).toHaveClass('button--append-icon');
      expect(appendIcon).toBeInTheDocument();
    });

    test('should be only icon', () => {
      render(
        <Button variant="primary" icon={IconPen} iconPlacement="only" id="icon-only-button">Button</Button>,
      );
      const only = screen.getByTestId('icon-only-button');
      const onlyIcon = only.querySelector('svg');
      expect(only).toHaveClass('button--icon-only');
      expect(onlyIcon).toBeInTheDocument();
    });
  });

  describe('generic options', () => {
    test('should have an alternative color', () => {
      render(<Button variant="primary" id="alt-button" alt>Button</Button>);
      expect(screen.getByTestId('alt-button')).toHaveClass('button--alt');
    });

    test('should have a shadow', () => {
      render(<Button variant="primary" id="shadow-button" shadow>Button</Button>);
      expect(screen.getByTestId('shadow-button')).toHaveClass('button--shadow');
    });

    test('should be loading', () => {
      render(<Button variant="primary" id="loading-button" loading>Button</Button>);
      expect(screen.getByTestId('loading-button')).toHaveClass('button--loading');
    });

    test('should be content-width', () => {
      render(<Button variant="primary" id="content-width-button" contentWidth>Button</Button>);
      expect(screen.getByTestId('content-width-button')).toHaveClass('button--content-width');
    });
  });
});
