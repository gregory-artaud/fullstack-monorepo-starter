import { fireEvent, render, screen } from '@testing-library/react';
import { useState } from 'react';
import { describe, expect, test } from 'vitest';

describe('dummy test', () => {
  test('should increase count by 1', () => {
    // Arrange
    const ButtonWithCount = () => {
      const [count, setCount] = useState(0);
      return (
        <>
          <div data-testid="count">{count}</div>

          <button onClick={() => setCount((previous) => previous + 1)}>
            Increase
          </button>
        </>
      );
    };

    // Act
    render(<ButtonWithCount />);

    const count = screen.getByTestId('count');
    const button = screen.getByText('Increase');

    fireEvent.click(button);

    // Assert
    expect(count.textContent).toBe('1');
  });
});
