import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import Input from './Input';
import { IconCar } from '../../Icon/Icons';

describe('Input component', () => {
  describe('with default configuration', () => {
    test('it should mount with default classes', () => {
      render(<Input id="input-id" />);
      const field = screen.getByTestId('input-id-wrapper');
      const label = field.querySelector('label');
      expect(field).toBeInTheDocument();
      expect(field).toHaveClass('form-field');
      expect(label).toHaveClass('form-field__wrapper');
    });

    test('it should have an input with default classes and type', () => {
      render(<Input id="input-id" />);
      const input = screen.getByTestId('input-id');
      expect(input).toHaveClass('form-field__text');
      expect(input).toHaveAttribute('type', 'text');
    });
  });

  describe('with addon', () => {
    test('it should have a text addon', () => {
      render(<Input addon="text-addon" id="input-id" />);
      const field = screen.getByTestId('input-id-wrapper');
      const addon = screen.getByTestId('input-id-addon');
      expect(field).toHaveClass('form-field--with-prepend-text');
      expect(addon).toBeInTheDocument();
    });

    test('it should have an icon addon', () => {
      render(<Input addon={IconCar} id="input-id" />);
      const field = screen.getByTestId('input-id-wrapper');
      const addon = screen.getByTestId('input-id-addon');
      expect(field).toHaveClass('form-field--with-prepend-icon');
      expect(addon).toBeInTheDocument();
    });

    test('it should have an append addon', () => {
      render(<Input addon="text-addon" addonPlacement="append" id="input-id" />);
      const field = screen.getByTestId('input-id-wrapper');
      expect(field).toHaveClass('form-field--with-append-text');
    });
  });

  describe('with error', () => {
    test('it should have proper classes if `hasError` is true', () => {
      render(<Input hasError id="input-id" />);
      const field = screen.getByTestId('input-id-wrapper');
      expect(field).toHaveClass('form-field--error');
    });

    test('it should have proper `aria` attributes', () => {
      render(<Input errorId="error-id" hasError id="input-id" />);
      const input = screen.getByTestId('input-id');
      expect(input).toHaveAttribute('aria-errormessage', 'error-id');
      expect(input).toHaveAttribute('aria-invalid', 'true');
    });
  });

  test('it should have proper `aria-describedby` if an hint id is passed', () => {
    render(<Input hintId="hint-id" id="input-id" />);
    const input = screen.getByTestId('input-id');
    expect(input.getAttribute('aria-describedby')).toContain('hint-id');
  });

  test('it should have proper classes if disabled', () => {
    render(<Input disabled id="input-id" />);
    const field = screen.getByTestId('input-id-wrapper');
    const input = screen.getByTestId('input-id');
    expect(field).toHaveClass('form-field--disabled');
    expect(input).toBeDisabled();
  });

  test('it should have proper classes if small', () => {
    render(<Input id="input-id" size="small" />);
    const input = screen.getByTestId('input-id');
    expect(input).toHaveClass('form-field__text--small');
  });
});
