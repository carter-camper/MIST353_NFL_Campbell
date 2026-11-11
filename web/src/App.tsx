import { useState } from 'react';
import { Button } from '@astryxdesign/core/Button';
import TeamsByConference from './TeamsByConference';
import SameDivision from './SameDivision';
import TeamsByColor from './TeamsByColor';

const pages = {
  'By Conference': TeamsByConference,
  'Same Division': SameDivision,
  'By Color': TeamsByColor,
};
type PageName = keyof typeof pages;

export default function App() {
  const [page, setPage] = useState<PageName>('By Conference');
  const Page = pages[page];

  return (
    <div style={{ maxWidth: 900, margin: '0 auto', padding: 24 }}>
      <h1 style={{ textAlign: 'center' }}>NFL Playoffs App</h1>
      <nav style={{ display: 'flex', justifyContent: 'center', gap: 8, margin: '16px 0' }}>
        {(Object.keys(pages) as PageName[]).map(name => (
          <Button
            key={name}
            label={name}
            variant={page === name ? 'primary' : undefined}
            onClick={() => setPage(name)}
          />
        ))}
      </nav>
      <Page />
    </div>
  );
}