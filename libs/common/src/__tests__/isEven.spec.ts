import { describe, expect, test } from 'vitest';
import { isEven } from '../main';

describe('isEven', () => {
  test('should be even', () => {
    expect(isEven(2)).toBeTruthy();
  });
});
