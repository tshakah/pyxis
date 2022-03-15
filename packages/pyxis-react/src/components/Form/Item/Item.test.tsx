import React from 'react';
import { render, screen } from '@testing-library/react';
import Form from 'components/Form';

describe('Form Item component', () => {
  describe('with input', () => {
    test('should render', () => {
      render(
        <Form.Item id="default">
          <Form.Input />
        </Form.Item>,
      );
      const item = screen.getByTestId('default');
      const wrapper = item.querySelector('div.form-item__wrapper');
      const input = item.querySelector('input.form-field__text');
      expect(item).toBeInTheDocument();
      expect(item).toHaveClass('form-item');
      expect(wrapper).toBeInTheDocument();
      expect(input).toBeInTheDocument();
      expect(input).toHaveAttribute('id', 'default-field');
    });
  });

  describe('with label', () => {
    test('should render', () => {
      render(
        <Form.Item id="item-with-label">
          <Form.Label>Label</Form.Label>
        </Form.Item>,
      );
      const item = screen.getByTestId('item-with-label');
      const label = item.querySelector('label.form-label');
      expect(label).toBeInTheDocument();
      expect(label).toHaveAttribute('id', 'item-with-label-label');
      expect(label).toHaveAttribute('for', 'item-with-label-field');
    });
  });

  describe('with additional content', () => {
    test('should render', () => {
      render(
        <Form.Item id="item-with-content">
          <Form.AdditionalContent>
            <div className="additional-content">Additional Content</div>
          </Form.AdditionalContent>
        </Form.Item>,
      );
      const item = screen.getByTestId('item-with-content');
      const additionalContent = item.querySelector('div.additional-content');
      expect(additionalContent).toBeInTheDocument();
    });
  });

  describe('with message', () => {
    test('should render hint message', () => {
      render(
        <Form.Item hint="Hint message" id="hint-message">
          <Form.Input />
        </Form.Item>,
      );
      const item = screen.getByTestId('hint-message');
      const hint = item.querySelector('.form-item__hint');
      const input = item.querySelector('input.form-field__text');
      expect(item).toBeInTheDocument();
      expect(item).toHaveClass('form-item');
      expect(hint).toBeInTheDocument();
      expect(hint).toHaveAttribute('id', 'hint-message-hint');
      expect(input).toHaveAttribute('id', 'hint-message-field');
      expect(input?.getAttribute('aria-describedby')?.includes('hint-message-hint')).toBe(true);
    });

    test('should render error message', () => {
      render(
        <Form.Item errorMessage="Error message" id="error-message">
          <Form.Input />
        </Form.Item>,
      );
      const item = screen.getByTestId('error-message');
      const error = item.querySelector('.form-item__error-message');
      const input = item.querySelector('input.form-field__text');
      expect(item).toBeInTheDocument();
      expect(item).toHaveClass('form-item');
      expect(error).toBeInTheDocument();
      expect(error).toHaveAttribute('id', 'error-message-error');
      expect(input).toBeInTheDocument();
      expect(input).toHaveAttribute('id', 'error-message-field');
      expect(input).toHaveAttribute('aria-errormessage', 'error-message-error');
      expect(input).toHaveAttribute('aria-invalid');
    });

    test('should not render hint if error message is present', () => {
      render(
        <Form.Item errorMessage="Error message" hint="Hint message" id="error-hint-message">
          <Form.Input />
        </Form.Item>,
      );
      const item = screen.getByTestId('error-hint-message');
      const error = item.querySelector('.form-item__error-message');
      const hint = item.querySelector('.form-item__hint');
      expect(item).toBeInTheDocument();
      expect(item).toHaveClass('form-item');
      expect(error).toBeInTheDocument();
      expect(hint).not.toBeInTheDocument();
    });
  });

  describe('with children', () => {
    test('should render correct order', () => {
      render(
        <Form.Item id="order">
          <Form.AdditionalContent>
            <div className="custom-content">Custom message</div>
          </Form.AdditionalContent>
          <Form.Input />
          <Form.Label>Label</Form.Label>
        </Form.Item>,
      );

      const item = screen.getByTestId('order');
      const [label, formItemWrapper, additionalContent] = item.children;
      expect(label).toHaveClass('form-label');
      expect(formItemWrapper).toHaveClass('form-item__wrapper');
      expect(additionalContent).toHaveClass('custom-content');
    });
  });

  describe('generic options', () => {
    test('should have a custom class', () => {
      render(
        <Form.Item className="custom-class-name" id="custom-class">
          <Form.Input />
        </Form.Item>,
      );
      expect(screen.getByTestId('custom-class')).toHaveClass('form-item custom-class-name');
    });
  });
});
