namespace DEVOPS5.Domain
{
    public class Game
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Genre { get; set; } = string.Empty;
        public double Price { get; set; }
        public DateTime ReleaseDate { get; set; }
    }
}
