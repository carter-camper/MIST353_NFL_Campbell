import { useState } from 'react';
import { Button } from '@astryxdesign/core/Button';
import { fetchData } from './api';

type Team = { TeamName: string; Conference: string; Division: string; TeamColors: string };

export default function TeamsByConference() {
  const [conference, setConference] = useState('');
  const [division, setDivision] = useState('');
  const [teams, setTeams] = useState<Team[]>([]);
  const [error, setError] = useState('');

  async function load() {
    const params: Record<string, string> = {};
    if (conference) params.conference = conference;
    if (division) params.division = division;
    try {
      setError('');
      setTeams(await fetchData('get_teams_by_conference_division/', params));
    } catch (e) {
      setError(String(e));
    }
  }

  return (
    <div style={{ padding: 24 }}>
      <h2>Teams by Conference and Division</h2>
      <div style={{ display: 'flex', gap: 12, margin: '16px 0' }}>
        <select value={conference} onChange={e => setConference(e.target.value)}>
          <option value="">Any conference</option>
          <option>AFC</option>
          <option>NFC</option>
        </select>
        <select value={division} onChange={e => setDivision(e.target.value)}>
          <option value="">Any division</option>
          <option>East</option>
          <option>West</option>
          <option>North</option>
          <option>South</option>
        </select>
        <Button label="Fetch Teams" variant="primary" onClick={load} />
      </div>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {teams.length > 0 && (
        <table>
          <thead>
            <tr><th>Team</th><th>Conference</th><th>Division</th><th>Colors</th></tr>
          </thead>
          <tbody>
            {teams.map(t => (
              <tr key={t.TeamName}>
                <td>{t.TeamName}</td><td>{t.Conference}</td><td>{t.Division}</td><td>{t.TeamColors}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}