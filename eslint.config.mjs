import pluginJs from '@eslint/js';
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default [
  {
    languageOptions: {
      globals: globals.browser,
    },
  },
  {
    ignores: [
      'coverage',
      'public',
      'dist',
      'pnpm-lock.yaml',
      'pnpm-workspace.yaml',
      '**/.eslintrc.cjs',
    ],
  },
  pluginJs.configs.recommended,
  ...tseslint.configs.recommended,
  eslintPluginPrettierRecommended,
];
