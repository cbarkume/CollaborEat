package learn.collaboreat.domain;

import learn.collaboreat.data.FeedbackJDBCTemplateRepository;
import learn.collaboreat.data.FeedbackRepository;
import learn.collaboreat.models.Feedback;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FeedbackService {

    private final FeedbackRepository repository;

    public FeedbackService(FeedbackRepository repository) {
        this.repository = repository;
    }

    public List<Feedback> findAll() {
        return repository.findAll();
    }

    public Feedback findById(int feedbackId) {
        return repository.findById(feedbackId);
    }

    public Result<Feedback> add(Feedback feedback) {
        Result<Feedback> result = new Result<>();
        if (feedback == null) {
            result.addMessage("Feedback must exist.", ResultType.INVALID);
            return result;
        }

        if (feedback.getFeedbackId() != 0) {
            result.addMessage("Feedback ID must not be set in order to add.", ResultType.INVALID);
            return result;
        }

        feedback = repository.add(feedback);
        result.setPayload(feedback);
        return result;
    }

    public Result<Feedback> update(Feedback feedback) {
        Result<Feedback> result = new Result<>();
        if (feedback == null) {
            result.addMessage("Feedback must exist.", ResultType.INVALID);
            return result;
        }

        if (feedback.getFeedbackId() <= 0) {
            result.addMessage("Feedback ID must be set in order to update.", ResultType.INVALID);
            return result;
        }

        if (!repository.update(feedback)) {
            String msg = String.format("feedbackId: %s, not found.", feedback.getFeedbackId());
            result.addMessage(msg, ResultType.NOT_FOUND);
        }

        return result;
    }

    public boolean deleteById(int feedbackId) {
        return repository.deleteById(feedbackId);
    }
}