import { useState } from 'react';
import { Button } from '@astryxdesign/core/Button';
import { fetchData } from './api';

type Team = { TeamName: string; TeamColors: string };

export default function TeamsByColor() {
  const [color, setColor] = useState('');
  const [teams, setTeams] = useState<Team[]>([]);
  const [error, setError] = useState('');
  const [searched, setSearched] = useState(false);

  async function load() {
    if (!color.trim()) return setError('Enter a color first.');
    try {
      setError('');
      setTeams(await fetchData('get_teams_by_color/', { color: color.trim() }));
      setSearched(true);
    } catch (e) {
      setError(String(e));
    }
  }

  return (
    <div style={{ padding: 24 }}>
      <h2>Teams by Color</h2>
      <div style={{ display: 'flex', gap: 12, margin: '16px 0' }}>
        <input
          placeholder="e.g. Blue"
          value={color}
          onChange={e => setColor(e.target.value)}
          onKeyDown={e => e.key === 'Enter' && load()}
        />
        <Button label="Search" variant="primary" onClick={load} />
      </div>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {searched && teams.length === 0 && <p>No teams found with "{color}".</p>}
      {teams.length > 0 && (
        <table>
          <thead><tr><th>Team</th><th>Colors</th></tr></thead>
          <tbody>
            {teams.map(t => <tr key={t.TeamName}><td>{t.TeamName}</td><td>{t.TeamColors}</td></tr>)}
          </tbody>
        </table>
      )}
    </div>
  );
}